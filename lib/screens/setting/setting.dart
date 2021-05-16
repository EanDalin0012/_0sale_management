import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/setting/widget/language_choice.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/setting/widget/profile_header.dart';
import 'package:sale_management/share/model/key/language_key.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/static/language_static.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sale_management/screens/setting/widget/stock_choice.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  var style = TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500);
  var switchValue = true;
  var language = 'English';
  var languageCode = 'en';
  List<dynamic> vDataStock = [];
  Map vStock;
  bool status2 = true;
  bool status4 = true;

  @override
  void initState() {
    this._fetchItemsStock();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(MemoryStore.languageStore != null) {
      this.language = MemoryStore.languageStore[LanguageKey.text];
      this.languageCode = MemoryStore.languageStore[LanguageKey.code];

    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                    ),
                    _buildListTile(title: 'Ean Dalin', svgIcon: 'assets/icons/User.svg'),
                    Divider(
                      height: 2,
                    ),
                    Divider(),
                    _buildListTile(title: '20201548', svgIcon: 'assets/icons/featured_play_list_black_24dp.svg'),
                    Divider(
                      height: 2,
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(
                  left: 10,
                  top: 17
                ),
                decoration: BoxDecoration(
                    color: Color(0xCD939BA9).withOpacity(0.3)
                ),
                width: MediaQuery.of(context).size.width,
                child: Text('Language Choice', style: style,),
              ),
              Container(
                height: 60,
                padding: EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10
                ),
                child: GestureDetector(
                  onTap: () => languageChoice(),
                  child: Row(
                    children: <Widget>[
                      _listTileLeading(
                          height: 25,
                          width: 20,
                          svgIcon: 'assets/icons/language_black_24dp.svg'
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('${this.language}', style: style,))
                    ],
                  ),
                ),
              ),

              this.vStock != null ? Container(
                height: 50,
                padding: EdgeInsets.only(
                    left: 10,
                    top: 17
                ),
                decoration: BoxDecoration(
                    color: Color(0xCD939BA9).withOpacity(0.3)
                ),
                width: MediaQuery.of(context).size.width,
                child: Text('Sale From Stock', style: style,),
              ) : Container(),

              this.vStock != null  ? GestureDetector(
                onTap: () => changeStock(this.vStock),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  child: Row(
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.database,),
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text('${this.vStock[StockKey.name]}', style: style,))
                      ],
                    ),
                ),
              ) : Container(),

              Container(
                height: 50,
                padding: EdgeInsets.only(
                    left: 10,
                    top: 17
                ),
                decoration: BoxDecoration(
                    color: Color(0xCD939BA9).withOpacity(0.3)
                ),
                width: MediaQuery.of(context).size.width,
                child: Text('Security', style: style,),
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                leading: Icon(Icons.lock, size: 30,color: dropColor,),
                title: Text('User Fingerprint to Login'),
              ),
              ListTile(
                leading: Icon(Icons.fingerprint_rounded, size: 30,color: dropColor,),
                title: Text('User Fingerprint to Login'),
                trailing: Container(
                  width: 50,
                  child: FlutterSwitch(
                    width: 55.0,
                    height: 25.0,
                    valueFontSize: 12.0,
                    toggleSize: 18.0,
                    value: status4,
                    onToggle: (val) {
                      setState(() {
                        status4 = val;
                      });
                    },
                  ),
                ),
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  // onPressedGetLocal().then((value) {
                  // });
                },
                child: Text("Set Flat Button",style: TextStyle(fontSize: 20.0),),
              ),
            ],
          )
        ),
      ),
    );
  }
  Container _buildListTile({String title, String svgIcon}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: <Widget>[
          _listTileLeading(
              height: 25,
              width: 20,
              svgIcon: svgIcon
          ),
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(title, style: style,))
        ],
      ),
    );
  }

  Padding _listTileLeading({
    String svgIcon,
    Color color,
    double width,
    double height,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0,0,0,0),
      child: SvgPicture.asset(
        svgIcon,
        width: width,
        height: height,
        color: color,
      ),
    );
  }

  languageChoice() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: LanguageChoice(
              code: this.languageCode,
              onChange: (value) {
                setState(() {
                  MemoryStore.languageStore = value;
                  this.language = value[LanguageKey.text];
                  this.languageCode = value[LanguageKey.code];
                });
              },
            )
          );
        });
    // _showToast();

  }

  changeStock(Map data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: StockChoice(
                vStock: data,
                mList: this.vDataStock,
                onChanged: (value) {
                  setState(() {
                    this.vStock = value;
                  });
                },
              )
          );
        });
    // _showToast();

  }

  _showToast() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
    );
  }

  _fetchItemsStock() async {
    final data = await rootBundle.loadString('assets/json_data/stock_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vDataStock = mapItems['stocks'];
      this.vStock = this.vDataStock[0];
    });
    return this.vDataStock;
  }

  Future<String> onPressedGetLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('yourKey');
  }
}
