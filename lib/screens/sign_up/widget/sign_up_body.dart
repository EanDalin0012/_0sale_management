import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/sign_in/sign_in_screen.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/screens/widgets/gender_option/gender_optional.dart';


class SignUpBody extends StatefulWidget {
  const SignUpBody({Key key}) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final _formKey = GlobalKey<FormState>();
  var emailController = new TextEditingController();
  var firstNameController = new TextEditingController();
  var lastNameController = new TextEditingController();
  var passwordController = new TextEditingController();
  var confPasswordController = new TextEditingController();
  var isClickSave = false;
  var gender;

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
          children: <Widget>[
            _buildBody(),
            GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                create();
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.redAccent,
                child: Center(child: Text('Create', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
              ),
            )
          ]
      ),
    );
  }

  Widget _buildBody() {
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
                        Text("Create Account", style: headingStyle),
                        Text(
                          "Complete your details or continue \nwith social media",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  _buildFirstNameField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildLastNameField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  GenderForm(
                    size: size,
                    autovalidate: false,
                    initialValue: this.gender,
                    onChanged: (value) {
                      checkFormValid();
                      setState(() {
                        this.gender = value;
                      });
                    },
                    validator: (value) {
                      if(value == null) {
                        return 'Please select gender!';
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  buildEmailFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildPasswordField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildConfPasswordField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                ]
            )
          )
        )
    );
  }

  TextFormField _buildFirstNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: firstNameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Your first name is empty.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your fist name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildLastNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: lastNameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        print('value value: ${value}');
        if (value.isEmpty) {
          print('value hgf: ${value}');
          return "Your last name is empty.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.next,
      controller: passwordController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Your password is empty.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildConfPasswordField() {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.next,
      controller: confPasswordController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Your confirm password is empty.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Enter your confirm password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }


  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (value) {
        if (value.isEmpty) {
          return "Your email is empty.";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return "Please enter valid email!";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/mark_as_unread_black_24dp.svg"),
      ),
    );
  }

  //
  // void _handleRadioValueChange(int value) {
  //   setState(() {
  //     _radioValue = value;
  //
  //     switch (_radioValue) {
  //       case 0:
  //         break;
  //       case 1:
  //         break;
  //       case 2:
  //         break;
  //     }
  //   });
  // }

  void create() {
    this.isClickSave = true;
    if( _formKey.currentState.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  void checkFormValid() {
    if(isClickSave) {
      _formKey.currentState.validate();
    }
  }

}
