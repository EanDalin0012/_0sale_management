

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/constant/text_style.dart';

class ManagementScreen extends StatelessWidget {

  var colorContain = Color(0xffd9dbdb).withOpacity(0.9);
  Color _textColor= Colors.purple[900];
  Color _iconColor = Colors.purple[900];
  double _iconSize = 25;
  double wContainer = 60;
  double hContainer = 50;
  BoxBorder border = Border.all(color: Colors.blueGrey[100].withOpacity(0.2), width: 4);
  var textStyle = TextStyle(color: Colors.purple[900],fontSize: 15,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = (size.width / 3) - 25;
    double h = w - 20;
    print('w:$w,h:$h');
    return Scaffold(
        appBar: _appBar(),
        body: Container(
          color: Colors.white10.withOpacity(0.2),
          child: Container(
            padding: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Color(0xfff1f1f1)
            ),child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // drawerHandler(),
                  item1(w,h),
                  SizedBox(height: 20,),
                  item0(w, h),
                  SizedBox(height: 20,),
                  // item2(w, h),
                ]
            ),
          )
          )
        ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Text('Management', style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900]
    );
  }

  item1(double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            // Navigator.pop(widget.context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) =>
            //       CategoryScreen()
            //   ),
            // );

          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.cuttlefish,size: _iconSize , color: _iconColor,)),
                ),
                SizedBox(height: 5,),
                Text('Category',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Product()),
            // );
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.productHunt,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Product',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print('Vendor Click');
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.vimeo,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Vendor',style: textStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }

  item0(double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Customer()),
            // );
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child:Center(child: FaIcon(FontAwesomeIcons.users,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Member',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print('Vendor Click');
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.layerGroup,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Import',style: textStyle),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {

          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                      borderRadius: BorderRadius.circular(50),
                      border: border

                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.database,size: _iconSize, color: _iconColor,)),
                ),
                SizedBox(height: 5,),
                Text('Stock',style: textStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
