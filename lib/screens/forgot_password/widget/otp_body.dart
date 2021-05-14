import 'package:flutter/material.dart';
import 'package:sale_management/screens/forgot_password/new_password.dart';
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
  var isClickSave = false;
  FocusNode pin2FN;
  FocusNode pin3FN;
  FocusNode pin4FN;
  final pinStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  final _formKey = GlobalKey<FormState>();
  var invalid = '';

  @override
  void initState() {
    super.initState();
    pin2FN = FocusNode();
    pin3FN = FocusNode();
    pin4FN = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FN?.dispose();
    pin3FN?.dispose();
    pin4FN?.dispose();
  }


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
            _buildFormOTP(),
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
              onPressed: () => confirm(),
            )
          ]
      )
    );
  }


  Widget _buildFormOTP() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  validator: (value) {
                    if (value.isEmpty) {
                      return this.invalid;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nextField(value, pin2FN);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin2FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value.isEmpty) {
                      return this.invalid;
                    }
                    return null;
                  },
                  decoration: inputDecoration,
                  onChanged: (value) => nextField(value, pin3FN),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin3FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return this.invalid;
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) => nextField(value, pin4FN),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin4FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return this.invalid;
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FN.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  void nextField(String value, FocusNode focusNode) {
    checkFormValid();
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  void confirm() {
    this.isClickSave = true;
    if( _formKey.currentState.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewPasswordScreen(email: this.email)),
      );
    }
  }

  void checkFormValid() {
    if(isClickSave) {
      _formKey.currentState.validate();
    }
  }
}
