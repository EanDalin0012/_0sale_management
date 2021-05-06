import 'package:flutter/material.dart';
import 'package:sale_management/screens/sign_in/widget/body_sign_in.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/static/language_static.dart';
import 'package:sale_management/share/utils/local_storage.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign In", style: TextStyle(fontFamily: fontFamilyDefault),),
      // ),
      body: SignInBody(),
    );
  }
}
