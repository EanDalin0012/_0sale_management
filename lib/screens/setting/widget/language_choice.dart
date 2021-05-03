import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/utils/local_storage.dart';

class LanguageChoice extends StatefulWidget {
  final ValueChanged<Map> onChange;
  LanguageChoice({
    this.onChange
  });

  @override
  _LanguageChoiceState createState() => _LanguageChoiceState();
}

class _LanguageChoiceState extends State<LanguageChoice> {
  double kDefaultPadding = 20.0;
  var isCheckKh = false;
  var isCheckEn = false;
  var isCheckZn = false;
  var key = 'lang';

  Map vData = {
    LanguageKey.code: '',
    LanguageKey.value: '',
  };

  @override
  void initState() {
    UtilLocalStorage.get(key: 'lang').then((vDataResponse) {
      if(vData != null) {
        setState(() {
            if(vDataResponse[LanguageKey.code].toString() == 'kh') {
              this.isCheckKh = true;
              vData = {
                LanguageKey.code: 'kh',
                LanguageKey.value: 'ខ្មែរ',
              };
            } else if(vDataResponse[LanguageKey.code].toString() == 'en') {
              this.isCheckEn = true;
              vData = {
                LanguageKey.code: 'en',
                LanguageKey.value: 'English',
              };
            } else if (vDataResponse[LanguageKey.code].toString() == 'zn') {
              this.isCheckZn = true;
              vData = {
                LanguageKey.code: 'zn',
                LanguageKey.value: '中文',
              };
            }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.45,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.deepPurple,
              child: Center(child: Text('Language', style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: fontFamilyDefault,
                  fontWeight: FontWeight.w500),)),
            ),
            InkWell(
              onTap: () {
                UtilLocalStorage.set(key: key, info: vData);
                setState(() {
                  this.isCheckKh = true;
                  this.isCheckZn = false;
                  this.isCheckEn = false;
                });
                vData = {
                  LanguageKey.code: 'kh',
                  LanguageKey.value: 'ខ្មែរ',
                };
                pop(context);
                UtilLocalStorage.set(key: key, info: vData);
                widget.onChange(vData);
              },
              child: Container(
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFC1C1C1)),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    this.isCheckKh ? _checked() : _buildRadio(),
                    SizedBox(width: 15,),
                    Text('ខ្មែរ', style: TextStyle(fontSize: 20,
                        color: Colors.black,
                        fontFamily: fontFamilyDefault,
                        fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                UtilLocalStorage.set(key: key, info: vData);
                setState(() {
                  this.isCheckEn = true;
                  this.isCheckKh = false;
                  this.isCheckZn = false;
                });
                pop(context);
                vData = {
                  LanguageKey.code: 'en',
                  LanguageKey.value: 'English',
                };
                UtilLocalStorage.set(key: key, info: vData);
                widget.onChange(vData);
              },
              child: Container(
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFC1C1C1)),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    this.isCheckEn ? _checked() : _buildRadio(),
                    SizedBox(width: 15,),
                    Text('English', style: TextStyle(fontSize: 20,
                        color: Colors.black,
                        fontFamily: fontFamilyDefault,
                        fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  this.isCheckZn = true;
                  this.isCheckEn = false;
                  this.isCheckKh = false;
                });
                pop(context);
                vData = {
                  LanguageKey.code: 'zn',
                  LanguageKey.value: '中文',
                };
                UtilLocalStorage.set(key: key, info: vData);
                widget.onChange(vData);
              },
              child: Container(
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFC1C1C1)),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    this.isCheckZn ? _checked() : _buildRadio(),
                    SizedBox(width: 15,),
                    Text('中文', style: TextStyle(fontSize: 20,
                        color: Colors.black,
                        fontFamily: fontFamilyDefault,
                        fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

  Padding _listTileLeading({
    String svgIcon,
    Color color,
    double width,
    double height,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SvgPicture.asset(
        svgIcon,
        width: width,
        height: height,
        color: color,
      ),
    );
  }

  Widget _checked() {
    return _listTileLeading(
        height: 25,
        width: 20,
        color: Colors.deepPurpleAccent,
        svgIcon: 'assets/icons/check_circle_outline_black_24dp.svg'
    );
  }

  Container _buildRadio() {
    return Container(
      height: 26,
      width: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Color(0xFFC1C1C1))
      ),
    );
  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }
}
