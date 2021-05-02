import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/setting/widget/profile_header.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  var style = TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500);
  var switchValue = true;
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
              ProfileHeader(
                avatar: NetworkImage('https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg'),
                coverImage: NetworkImage('https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg'),
                title: "Ramesh Mana",
                subtitle: "Manager",
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.white,
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "User Information",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Divider()
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
