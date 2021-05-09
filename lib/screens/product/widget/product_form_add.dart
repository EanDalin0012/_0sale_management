import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/screens/widgets/category_dropdown/category_dropdown.dart';
import 'package:sale_management/share/model/key/category_key.dart';
import 'package:sale_management/screens/product/product_success_screen.dart';
import 'package:sale_management/share/model/key/product_key.dart';

class ProductFormAdd extends StatefulWidget {
  @override
  _ProductFormAddState createState() => _ProductFormAddState();
}

class _ProductFormAddState extends State<ProductFormAdd> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  Size size;
  var isClickSave = false;

  var nameController = new TextEditingController();
  var categoryController = new TextEditingController();
  var browController = new TextEditingController();
  var remarkController = new TextEditingController();
  Map categoryMap;

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
                  mySave();
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.redAccent,
                  child: Center(child: Text('Save', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                ),
              )
            ]
        )
    );
  }


  Widget _body() {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child:  Column(
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                            Text("Register Product", style: headingStyle),
                            Text("Complete your details",textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      _buildNameField(),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      _buildCategoryField(),
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
          return "Invalid Name.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter product name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: remarkController,
      onChanged: (value) => checkFormValid(),
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
        onTap: () async {
          final category = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryDropdownPage(vCategory: this.categoryMap,)),
          );
          if(category == null) {
            return;
          }
          setState(() {
            this.categoryMap = category;
            this.categoryController.text = this.categoryMap[CategoryKey.name];
            checkFormValid();
          });
        },
        keyboardType: TextInputType.text,
        controller: categoryController,
        onChanged: (value) => checkFormValid(),
        validator: (value) {
          if (value.isEmpty) {
            return "Invalid category.";
          }
          return null;
        },
        readOnly: true,
        decoration: InputDecoration(
          labelText: "Category",
          hintText: "Select category",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
        ),
      );
  }

  TextFormField _buildBrowsField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: browController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Brows",
        hintText: "Brows to image",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/attachment_black_24dp.svg"),
      ),
    );
  }

  void mySave() {
    this.isClickSave = true;
    if( _formKey.currentState.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductSuccessScreen(
          isAddScreen: true,
          vData: {
            ProductKey.name: this.nameController.text,
            ProductKey.category: categoryController.text,
            ProductKey.remark: this.remarkController.text,
          },
        )),
      );
    }
  }

  void checkFormValid() {
    if(isClickSave) {
      _formKey.currentState.validate();
    }
  }
}
