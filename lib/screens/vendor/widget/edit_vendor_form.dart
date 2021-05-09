import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/share/model/key/vendor_key.dart';
import 'package:sale_management/screens/vendor/vendor_success_screen.dart';

class EditVendorForm extends StatefulWidget {
  final Map vVendor;
  EditVendorForm({
    Key key,
    @required this.vVendor
  }):super(key: key);

  @override
  _AddMemberFormState createState() => _AddMemberFormState();
}

class _AddMemberFormState extends State<EditVendorForm> {

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  Size size;
  var isClickUpdate = false;
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var emailController = new TextEditingController();
  var remarkController = new TextEditingController();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }


  @override
  void initState() {
    nameController.text = widget.vVendor[VendorKey.name];
    phoneController.text = widget.vVendor[VendorKey.phone];
    emailController.text = widget.vVendor[VendorKey.email];
    remarkController.text = widget.vVendor[VendorKey.remark];
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
                      Text("Update Vendor", style: headingStyle),
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
                _buildEmailField(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                _buildRemarkField(),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
              ],
            ),
          ),
        )
    );
  }
  TextFormField _buildNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: nameController,
      textInputAction: TextInputAction.next,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid vendor name.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter vendor name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: phoneController,
      textInputAction: TextInputAction.next,
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

  TextFormField _buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      decoration: InputDecoration(
        labelText: "E-Mail",
        hintText: "Enter e-mail",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/mail_black_24dp.svg"),
      ),
    );
  }


  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: remarkController,
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
        MaterialPageRoute(builder: (context) => VendorSuccessScreen(
          isEditScreen: true,
          vData: {
            VendorKey.name: nameController.text,
            VendorKey.phone: phoneController.text,
            VendorKey.email: emailController.text,
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

