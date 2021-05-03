import 'package:flutter/material.dart';
import 'package:sale_management/screens/sign_in/widget/body_sign_in.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/utils/local_storage.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Map vData = {
    LanguageKey.code: 'en',
    LanguageKey.value: 'English',
  };


  @override
  Widget build(BuildContext context) {
    UtilLocalStorage.set(key: 'lang', info: vData);
    UtilLocalStorage.get(key: 'lang').then((value) {
      showMessage(data: value.toString());
   });

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign In", style: TextStyle(fontFamily: fontFamilyDefault),),
      // ),
      body: SignInBody(),
    );
  }

  showMessage({String data}) {
    print('pricnt');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              ), //this right here
              child: Text('${data}')
          );
        });
    // _showToast();

  }
}
