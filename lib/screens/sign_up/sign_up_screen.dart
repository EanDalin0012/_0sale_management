import 'package:flutter/material.dart';
import 'package:sale_management/screens/sign_up/widget/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Sign Up"),
      ),
      body: SignUpBody(),
    );
  }
}
