import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDialog {

  static Widget showDialogYesNo(
      {
        BuildContext buildContext,
        Widget title,
        Widget content,
        double elevation,
        String btnRight,
        VoidCallback onPressedBntRight,
        String btnLeft,
        VoidCallback onPressedBntLeft,
      }) {
    showDialog (
        context: buildContext,
        builder: (BuildContext context) {
          var padding = EdgeInsets.all(10);
          return AlertDialog(
            elevation:elevation,
            title: Center(child: title),
            content: content,
            actions: <Widget>[
              InkWell(
                onTap: () {
                  print('print');
                  Navigator.pop(buildContext);
                  return onPressedBntLeft();
                },
                child: Container(
                    padding: padding,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.red[700].withOpacity(0.2),//Color(0xffd9dbdb).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 5,),
                            FaIcon(FontAwesomeIcons.timesCircle,size: 25,color: Colors.red),
                            SizedBox(width: 15,),
                            Text(btnLeft,style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w500),)
                          ],

                        )
                    )
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(buildContext);
                  return onPressedBntRight();
                },
                child: Container(
                    padding: padding,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.purple[900].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 5,),
                            FaIcon(FontAwesomeIcons.checkCircle,size: 25,color: Colors.purple[900]),
                            SizedBox(width: 15,),
                            Text(btnRight,style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w500),)
                          ],

                        )
                    )
                ),
              ),

            ],
          );});
  }

  Container _container() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
    );
  }
}
