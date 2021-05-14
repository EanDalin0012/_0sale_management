import 'package:flutter/material.dart';
import 'package:sale_management/screens/forgot_password/widget/oto_fields.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/text_style.dart';

final inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(color: Colors.grey.shade400),
);

final inputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
  border: inputBorder,
  focusedBorder: inputBorder,
  enabledBorder: inputBorder,
);

class OTPBody extends StatefulWidget {
  final String email;
  const OTPBody({Key key, this.email}) : super(key: key);

  @override
  _OTPBodyState createState() => _OTPBodyState();
}

class _OTPBodyState extends State<OTPBody> {
  var email = '';
  @override
  Widget build(BuildContext context) {
    if(widget.email != null) {
      this.email = widget.email;
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.0),
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                  Text("Please enter the 4-digit OTP", style: TextStyle(fontSize: 18.0, fontFamily: fontFamilyDefault)),
                  Text(
                    "OTP 4-digit sent to ${email}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.pink)
                  ),
                  Text(
                    "\nComplete your details",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            OTPFields(),
            SizedBox(height: 20.0),
            Text(
              "Expiring in 02:22",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            SizedBox(height: 10.0),
            TextButton(
              child: Text(
                "RESEND OTP",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                padding: const EdgeInsets.all(16.0),
                minimumSize: Size(200, 60),
              ),
              child: Text(
                "Confirm",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {},
            )
          ]
      )
    );
  }
}
