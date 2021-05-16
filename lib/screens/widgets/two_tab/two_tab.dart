import 'package:flutter/material.dart';
import 'package:sale_management/share/constant/constant_color.dart';
import 'package:sale_management/share/constant/text_style.dart';

class TwoTabs extends StatefulWidget {
  final String textTab0;
  final String textTab1;
  final ValueChanged<int> onChanged;
  const TwoTabs({Key key, @required this.textTab0, @required this.textTab1, this.onChanged}) : super(key: key);

  @override
  _TwoTabsState createState() => _TwoTabsState();
}

class _TwoTabsState extends State<TwoTabs> {
  String _place = "tab0";
  Size size;
  double w = 0.0;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    w = (size.width / 2 ) - 30;

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
                  _place = "tab0";
                  widget.onChanged(0);
                });
              },
              child: Container(
                width: w,
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                decoration: BoxDecoration(
                    color: _place == "tab0" ? Colors.white : null,
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: Text(
                    widget.textTab0,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _place != "tab0" ? dropColor : null,fontWeight: FontWeight.bold, fontFamily: fontFamilyDefault),
                  )
              )
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  _place = "tab1";
                  widget.onChanged(1);
                });
              },
              child: Container(
                width: w,
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                decoration: BoxDecoration(
                    color: _place == "tab1" ? Colors.white : null,
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: Text(
                    widget.textTab1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _place != "tab1" ? dropColor : null,fontWeight: FontWeight.bold),
                  )
              )
            )
            // GestureDetector()
          ]
      )
    );
  }
}
