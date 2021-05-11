import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDialog {

  static void showDialogYesNo(
      {
        BuildContext buildContext,
        Widget title,
        Widget content,
        double elevation,
        String btnYes,
        VoidCallback onPressedYes,
        String btnNo,
        VoidCallback onPressedNo,
      }) {
    showDialog (
        context: buildContext,
        builder: (BuildContext context) {
          var padding = EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10);
          var txtYes = 'Yes';
          var txtNo = 'No';
          if(btnYes != null) {
            txtYes = btnYes;
          }
          if(btnNo != null) {
            txtNo = btnYes;
          }
          return AlertDialog(
            elevation:elevation,
            title: Center(child: title),
            content: content,
            actions: <Widget>[
              FlatButton(
                child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,//Color(0xffd9dbdb).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.timesCircle,size: 25,color: Colors.white),
                            SizedBox(width: 5,),
                            Center(child: Text(txtNo,style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),)),
                            SizedBox(width: 5,),
                          ],

                        )
                    )
                ),
                onPressed: () {
                  Navigator.pop(buildContext);
                  return onPressedNo();
                },
              ),
              FlatButton(
                child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      color: Colors.purple[900].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // SizedBox(width: 5,),
                            _buildIconCheck(),
                            // FaIcon(FontAwesomeIcons.checkCircle,size: 25,color: Colors.purple[900]),
                            SizedBox(width: 5,),
                            Center(child: Text(txtYes,style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),)),
                            SizedBox(width: 5,),
                          ],

                        )
                    )
                ),
                onPressed: () {
                  Navigator.pop(buildContext);
                  return onPressedYes();
                  // Navigator.of(context).pop(true);
                  // SystemNavigator.pop();
                },
              ),

            ],
          );
        });
  }

  static void showConfirm(
      {
        BuildContext buildContext,
        Widget title,
        Widget content,
        double elevation,
        String btnConfirm,
        Color textColor,
        VoidCallback onPressedConfirm,
      }) {
    showDialog (
        context: buildContext,
        builder: (BuildContext context) {
          var padding = EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10);
          var txtConfirm = 'Confirm';
          if(btnConfirm != null) {
            txtConfirm = btnConfirm;
          }
          var color = Colors.black;
          if(textColor != null) {
            color = textColor;
          }
          return AlertDialog(
            elevation:elevation,
            title: Center(child: title),
            content: content,
            actions: <Widget>[
              FlatButton(
                child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      color: Colors.purple[900].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // SizedBox(width: 5,),
                            _buildIconCheck(),
                            // FaIcon(FontAwesomeIcons.checkCircle,size: 25,color: Colors.purple[900]),
                            SizedBox(width: 5,),
                            Center(child: Text(txtConfirm,style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w500, color: color),)),
                            SizedBox(width: 5,),
                          ],

                        )
                    )
                ),
                onPressed: () {
                  Navigator.pop(buildContext);
                  return onPressedConfirm();
                },
              ),

            ],
          );
        });
  }

  static Widget _buildIconCheck() {
    return Container(
      width: 30,
      height: 30,
      child: Image(image: AssetImage('assets/icons/success-green-check-mark.png')),
    );
  }
}
