import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/screens/member/member_success_screen.dart';
import 'package:sale_management/share/model/key/member_key.dart';

class EditMemberForm extends StatefulWidget {
  final Map vMember;
  EditMemberForm({Key key, this.vMember}):super(key: key);

  @override
  _AddMemberFormState createState() => _AddMemberFormState();
}

class _AddMemberFormState extends State<EditMemberForm> {

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;

  var browsController = new TextEditingController();
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var remarkController = new TextEditingController();
  Size size;
  var isClickUpdate = false;

  @override
  void initState() {
    nameController.text = widget.vMember[MemberKey.name];
    phoneController.text = widget.vMember[MemberKey.phone];
    remarkController.text = widget.vMember[MemberKey.remark];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
          children: <Widget>[
            _body(),
            GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                update();
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.redAccent,
                child: Center(child: Text('Update', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
              ),
            )
          ]
      ),
    );
  }

  Widget _body() {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                        Text("Update Member", style: headingStyle),
                        Text(
                          "Complete your details",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  _buildNameField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildPhoneField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildBrowsField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildRemarkField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                ]
            )
          )
        )
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: nameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid member name.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter member name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      controller: phoneController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid phone.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "Enter phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildBrowsField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: browsController,
      decoration: InputDecoration(
        labelText: "Brows",
        hintText: "Brows to image",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/attachment_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  void update() {
    this.isClickUpdate = true;
    if( _formKey.currentState.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MemberSuccessScreen(
          isEditScreen: true,
          vData: {
            MemberKey.name: nameController.text,
            MemberKey.phone: phoneController.text,
            MemberKey.url: browsController.text,
            MemberKey.remark: remarkController.text
          },
        )),
      );
    }
  }

  void checkFormValid() {
    if(isClickUpdate) {
      _formKey.currentState.validate();
    }
  }

}

