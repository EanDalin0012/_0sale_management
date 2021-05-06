import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sale_management/screens/sign_in/sign_in_screen.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/database/language_db.dart';
import 'package:sale_management/share/model/key/language_key.dart';
import 'package:sale_management/share/static/language_static.dart';

class ChooseLanguageScreen extends StatefulWidget {
  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  var color = Color(0xff32b8a1);
  var code = 'en';
  List<dynamic> vData = [
    {
      LanguageKey.code: 'kh',
      LanguageKey.text: 'ខ្មែរ',
      'url':'assets/countries/kh.svg'
    },
    {
      LanguageKey.code: 'en',
      LanguageKey.text: 'English',
      'url':'assets/countries/gb.svg'
    },{
      LanguageKey.code: 'zn',
      LanguageKey.text: '中文',
      'url':'assets/countries/cn.svg'
    }
  ];
  Size size;
  double height;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    SizeConfig.init(context);
    height = (size.height - SizeConfig.screenHeight * 0.06 - SizeConfig.screenHeight * 0.06);

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                Container(
                  child: Center(
                    child: Text('Choose the language', style: TextStyle(color: Color(0xFF3f496d), fontSize: 28, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault)),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                Container(
                  height: height - 78,
                  color: Colors.lightBlue[50].withOpacity(0.4),
                  child: Column(
                    children: vData.map((e) => _container(e)).toList(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    saveLanguage();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Container(
                    width: size.width,
                    height: 45,
                    color: Colors.red,
                    // margin: EdgeInsets.only(
                    //   left: 5,
                    //   right: 5
                    // ),
                    child: Center(child: Text('Next', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _container(Map map) {
    var isCheck = false;
    if(map[LanguageKey.code] == code) {
      isCheck = true;
    }
    return InkWell(
      onTap: () {
        setState(() {
          code = map[LanguageKey.code];
          if(map[LanguageKey.code] == 'kh') {
            MemoryStore.languageStore = {
              LanguageKey.id: 1,
              LanguageKey.code: 'kh',
              LanguageKey.text: 'ខ្មែរ',
              LanguageKey.isUse: code == 'kh' ? true: false
              };
          } else if(map[LanguageKey.code] == 'zn') {
            MemoryStore.languageStore = {
              LanguageKey.id: 3,
              LanguageKey.code: 'zn',
              LanguageKey.text: '中文',
              LanguageKey.isUse: code == 'zn' ? true: false
            };
          } else {
            MemoryStore.languageStore = {
              LanguageKey.id: 2,
              LanguageKey.code: 'en',
              LanguageKey.text: 'English',
              LanguageKey.isUse: code == 'en' ? true: false
            };
          }
          saveLanguage();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: isCheck ? Border(
            top: BorderSide(width: 2, color: color),
            bottom: BorderSide(width: 2, color: color),
          ): null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 55,
              height: 55,
              margin: EdgeInsets.all(15),
              // decoration: BoxDecoration(
              //     color: Colors.red
              // ),
              child: _buildFlag(map['url'].toString()),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.only(top: 10),
                child: Text(map[LanguageKey.text],style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault)),
              ),
            ),
            isCheck ? _buildIconCheck() : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildIconCheck() {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: SvgPicture.asset(
          'assets/icons/success_green_check_mark.svg',
          height: getProportionateScreenWidth(20),
          color: Color(0xFF32b8a1),
        ),
    );
  }

  Widget _buildFlag(String url) {
    return SvgPicture.asset(
        url.toString(),
        height: 50,
      );
  }

  void saveLanguage() {
    List<dynamic> languageData = [
      {
        LanguageKey.id: 1,
        LanguageKey.code: 'kh',
        LanguageKey.text: 'ខ្មែរ',
        LanguageKey.isUse: code == 'kh' ? true: false
      },
      {
        LanguageKey.id: 2,
        LanguageKey.code: 'en',
        LanguageKey.text: 'English',
        LanguageKey.isUse: code == 'en' ? true: false
      },{
        LanguageKey.id: 3,
        LanguageKey.code: 'zn',
        LanguageKey.text: '中文',
        LanguageKey.isUse: code == 'zn' ? true: false
      }
    ];
    languageData.map((e) {
      LanguageDataBase.create(e);
    }).toList();
  }
}
