import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/sign_in/widget/body_sign_in.dart';
import 'package:sale_management/share/static/language_static.dart';
import 'package:toast/toast.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool shouldPop = true;
  GlobalKey<NavigatorState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //Toast.show(MemoryStore.languageStore.toString(), context, gravity:  Toast.BOTTOM);
     return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign In", style: TextStyle(fontFamily: fontFamilyDefault),),
      // ),
      body: WillPopScope(
          onWillPop: () async {
            exit(0);
            return false;
          },
          child: SignInBody()
      ),
    );
  }
}
