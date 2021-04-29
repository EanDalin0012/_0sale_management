import 'package:flutter/material.dart';
import 'package:sale_management/screens/forgot_password/widget/forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: ForgotPasswordBody(),
    );
  }
}
