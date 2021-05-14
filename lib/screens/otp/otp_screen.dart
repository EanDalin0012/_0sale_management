import 'package:flutter/material.dart';
import 'package:sale_management/screens/otp/widget/otp_body.dart';

class OTPScreen extends StatefulWidget {
  final email;
  const OTPScreen({Key key, this.email}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black ),
          onPressed: ()  {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: OTPBody(email: widget.email),
    );
  }
}
