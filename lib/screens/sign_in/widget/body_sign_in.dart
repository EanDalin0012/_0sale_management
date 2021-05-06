import 'package:flutter/material.dart';
import 'package:sale_management/screens/sign_in/widget/sign_form.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/no_account_text/no_account_text.dart';
import 'package:sale_management/screens/widgets/socal_card/socal_card.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/static/language_static.dart';
import 'package:sale_management/share/utils/local_storage.dart';

class SignInBody extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    showMessage(data: MemoryStore.languageStore.toString());
    return SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: fontFamilyDefault,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocalCard(
                        svgIcon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        svgIcon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        svgIcon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        )
    );
  }

  showMessage({String data}) {
    return AlertDialog(
        title: Text(data.toString())
    );
    // _showToast();

  }

}
