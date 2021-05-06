import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/language_key.dart';
import 'package:sale_management/share/static/language_static.dart';

class LanguageChoice extends StatefulWidget {
  final ValueChanged<Map> onChange;
  final String code;
  LanguageChoice({
    this.code,
    this.onChange
  });

  @override
  _LanguageChoiceState createState() => _LanguageChoiceState();
}

class _LanguageChoiceState extends State<LanguageChoice> {
  var color = Color(0xff32b8a1);
  var code = 'en';
  double kDefaultPadding = 20.0;
  var isCheckKh = false;
  var isCheckEn = false;
  var isCheckZn = false;
  var key = 'lang';

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

  @override
  Widget build(BuildContext context) {
    if(widget.code != null) {
      code = widget.code;
    }
    return Container(
        height: MediaQuery.of(context).size.height * 0.40,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurple,
              child: Center(child: Text('Language', style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: fontFamilyDefault,
                  fontWeight: FontWeight.w500),)),
            ),
            Container(
              color: Colors.lightBlue[50].withOpacity(0.4),
              child: Column(
                children: vData.map((e) => _container(e)).toList(),
              ),
            ),
          ],
        )
    );
  }

  Widget _container(Map map) {
    var isCheck = false;
    if(map[LanguageKey.code] == code) {
      isCheck = true;
    }

    return InkWell(
      onTap: () {
        widget.onChange(map);
        pop(context);
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

  pop(BuildContext context) {
    Navigator.pop(context);
  }
}
