import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/screens/import/widget/add_import_form.dart';

class AddImportScreen extends StatefulWidget {
  @override
  _AddImportScreenState createState() => _AddImportScreenState();
}

class _AddImportScreenState extends State<AddImportScreen> {
  var cartArrowDownCount = 0;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _body(),
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    KeyboardUtil.hideKeyboard(context);
                  },
                  child: Container(
                    width: size.width,
                    height: 45,
                    color: Colors.red,
                    child: Center(child: Text('Next', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: fontFamilyDefault, fontSize: 18))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Text('Import', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900],
        actions: <Widget>[
          InkWell(
            onTap: () {
              // _showModelSheet();
            },
            child: Container(
              height: 80,
              width: 55,
              child: Stack(
                children: <Widget>[
                  Center(child:  FaIcon(FontAwesomeIcons.cartArrowDown,size: 25 , color: Colors.white,),),
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                        top: 5,
                        left: 30
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(child: Text(cartArrowDownCount.toString(), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800))),
                  ),
                ],
              ),
            ),
          ),
        ]
    );
  }

  Expanded _body() {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                          Text("Import new product", style: headingStyle),
                          Text(
                            "Complete your details",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    AddImportForm()
                  ])
          ),
        )
    );
  }

}
