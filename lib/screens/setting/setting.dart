import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sale_management/screens/setting/widget/language_choice.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/screens/setting/widget/profile_header.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/utils/local_storage.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  var style = TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500);
  var switchValue = true;
  var language = '';
  @override
  void initState() {
    UtilLocalStorage.get(key: 'lang').then((vData) {
      showMessage(data: vData.toString());
      if(vData != null) {
          setState(() {
            if(vData[LanguageKey.code] == 'kh') {
              this.language = 'ខ្មែរ';
            } else if(vData[LanguageKey.code] == 'en') {
              this.language = 'English';
            } else if (vData[LanguageKey.code] == 'zn') {
              this.language = '中文';
            }
          });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
                child: InkWell(
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
    print('pricnt');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ), //this right here
            child: LanguageChoice(
              onChange: (value) {
                setState(() {
                  this.language = value[LanguageKey.value];
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

    showMessage({String data}) {
      print('pricnt');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ), //this right here
                child: Text('${data}')
            );
          });
      // _showToast();

    }
}
