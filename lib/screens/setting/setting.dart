import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/share/constant/text_style.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  var style = TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Setting"),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 15),
                  color: Color(0xFF88070B),
                  child:Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset("assets/images/profile.jpg", width: 80, height: 80, fit: BoxFit.fill,),
                      ),
                      SizedBox(width: 15,),
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: "Name Surname\n", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamilyDefault, color: Colors.white)),
                                TextSpan(text: "@username", style: TextStyle(fontFamily: fontFamilyDefault, color: Colors.white)),
                              ]
                          )
                      )
                    ],
                  )
              ),
              ListTile(title: Text("Contact Us", style: style,), leading: Icon(Icons.phone),),
              ListTile(title: Text("Terms & Condition", style: style), leading: Icon(Icons.card_giftcard),),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingScreen()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
