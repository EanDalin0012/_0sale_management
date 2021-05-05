import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/language_key.dart';

class ChooseLanguageScreen extends StatefulWidget {
  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  var color = Color(0xc429ac9d);
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

    return WillPopScope(
      onWillPop:  () async {
        // return Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home()),
        // );
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                Container(
                  child: Center(
                    child: Text('Choose the language', style: TextStyle(color: Colors.blueGrey, fontSize: 28, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault)),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                Container(
                  height: height - 38,
                  color: Colors.lightBlue[50].withOpacity(0.4),
                  child: Column(
                    children: vData.map((e) => _container(e)).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _container(Map map) {
    var isCheck = false;
    if(map[LanguageKey.code] == 'en') {
      isCheck = true;
    }
    return Container(
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
              child: Text('Language',style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault)),
            ),
          ),
          isCheck ? _buildIconCheck() : Container()
        ],
      ),
    );
  }

  Widget _buildIconCheck() {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: SvgPicture.asset(
          'assets/icons/success-green-check-mark.svg',
          height: getProportionateScreenWidth(20),
          color: Colors.green,
        ),
    );
  }

  Widget _buildFlag(String url) {
    return SvgPicture.asset(
        url,
        height: 50,
      );
  }
}
