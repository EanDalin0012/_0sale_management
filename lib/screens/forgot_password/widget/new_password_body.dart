import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/sign_in/sign_in_screen.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/helper/keyboard.dart';

class NewPasswordBody extends StatefulWidget {
  final email;
  const NewPasswordBody({Key key, this.email}) : super(key: key);

  @override
  _NewPasswordBodyState createState() => _NewPasswordBodyState();
}

class _NewPasswordBodyState extends State<NewPasswordBody> {
  final _formKey = GlobalKey<FormState>();
  var user = '';
  var isClickChange = false;
  var pwController = new TextEditingController();
  var conPWController = new TextEditingController();
  var validateConPW = 'Invalid confirm password';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          children: <Widget>[
            _body(),
            GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                save();
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.redAccent,
                child: Center(child: Text('Change', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
              ),
            )
          ]
      )
    );
  }

  Widget _body() {
    if(widget.email != null) {
      this.user = widget.email;
    }
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
                    Text("Change Password", style: headingStyle),
                    Text(
                        "your email: ${user}",
                        style: TextStyle(color: Colors.pink)
                    ),
                    Text(
                      "\nComplete your details",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              buildPasswordFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              buildConfirmPasswordFormField(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      controller: conPWController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Invalid confirm password';
        } else if (this.pwController.text != this.conPWController.text) {
          return 'Password not match.';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Enter your confirm password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: pwController,
      textInputAction: TextInputAction.next,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid password";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  void save() {
    this.isClickChange = true;
    if( _formKey.currentState.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  void checkFormValid() {
    if(isClickChange) {
      _formKey.currentState.validate();
    }
  }
}
