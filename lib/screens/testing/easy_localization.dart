import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EasyLocalizationScreen extends StatefulWidget {
  const EasyLocalizationScreen({Key key}) : super(key: key);

  @override
  _EasyLocalizationScreenState createState() => _EasyLocalizationScreenState();
}

List languageCode = ["en", "km"];
List countryCode = ["US", "KM"];

class _EasyLocalizationScreenState extends State<EasyLocalizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildText(),
            SizedBox(
              height: 15,
            ),
            buildButton(),
            RaisedButton(
              child: Text(""),
              onPressed: () {
                setState(() async {
                  //await context.setLocale(Locale(languageCode[i]));
                  //EasyLocalization.of(context).locale = Locale('km', 'KH');
                });
              },
            )
          ],
        ),
      ),
    );
  }
  Widget buildText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        text("${('title'.tr().toString())}: ", Colors.blue),
        text('message'.tr().toString(), Colors.red),
      ],
    );
  }

  Widget buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button("English", 0),
        SizedBox(
          width: 50,
        ),
        button("தமிழ்", 1),
      ],
    );
  }

  Widget text(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 25),
    );
  }

  Widget button(String text, int i) {
    return RaisedButton(
      child: Text(text),
      onPressed: () {
        setState(() async {
          //await context.setLocale(Locale(languageCode[i]));
          //EasyLocalization.of(context).locale = Locale('', '');
        });
      },
    );
  }
}
