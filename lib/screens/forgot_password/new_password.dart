import 'package:flutter/material.dart';
import 'package:sale_management/screens/forgot_password/widget/new_password_body.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  const NewPasswordScreen({Key key, this.email}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Change New Password"),
      ),
      body: SafeArea(
        child: NewPasswordBody(email: widget.email),
      ),
    );
  }
}
