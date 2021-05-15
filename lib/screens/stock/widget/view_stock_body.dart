import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';

class ViewStockBody extends StatefulWidget {
  const ViewStockBody({Key key}) : super(key: key);

  @override
  _ViewStockBodyState createState() => _ViewStockBodyState();
}

class _ViewStockBodyState extends State<ViewStockBody> {
  String _place = "country";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Import New Product", style: headingStyle),
                Text(
                  "Complete your details.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          _placeNav(context),
        ],
      ),
    );
  }

  Widget _placeNav(BuildContext context) {
    return Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0XFFAEA1E5).withOpacity(0.3)
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _place = "country";
                  });
                },
                child: Container(
                  width: 160.0,
                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                  decoration: BoxDecoration(
                      color: _place == "country" ? Colors.white : null,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Text(
                    "My Country",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _place != "country" ? dropColor : null,fontWeight: FontWeight.bold, fontFamily: fontFamilyDefault),
                  )
                )
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    _place = "global";
                  });
                },
                child: Container(
                  width: 160.0,
                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                  decoration: BoxDecoration(
                      color: _place == "global" ? Colors.white : null,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Text(
                    "Global",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _place != "global" ? dropColor : null,fontWeight: FontWeight.bold),
                  )
                )
              )
            ]
        )
    );
  }
}
