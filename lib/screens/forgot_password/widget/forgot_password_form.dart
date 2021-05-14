import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/forgot_password/otp_screen.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/screens/widgets/default_button/default_button.dart';
import 'package:sale_management/screens/widgets/form_error/form_error.dart';
import 'package:sale_management/screens/widgets/no_account_text/no_account_text.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {

  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  String email;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPScreen(email: this.emailController.text)),
                );
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      )
    );
  }

  TextFormField _buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      onChanged: (value) => this._formKey.currentState.validate(),
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter your email";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return "Please enter valid email";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void save() {
    if( _formKey.currentState.validate()) {
      print('validate');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => CategorySuccessScreen(
      //     isAddScreen: true,
      //     vData: {
      //       CategoryKey.name: nameController.text,
      //       CategoryKey.remark: remarkController.text
      //     },
      //   )),
      // );
    }
  }

}
