import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/share/constant/text_style.dart';

class SearchWidget extends StatelessWidget {
  final String text;
  final String hintText;
  final ValueChanged<String> onChange;

  SearchWidget({
    this.text,
    this.hintText,
    this.onChange
  });

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black, fontSize: 15);
    final styleHint = TextStyle(color: Colors.black54);
    final style = this.text == null ? styleHint : styleActive;
    var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);

    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white, fontSize: 20),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white54),
            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.white54,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.white54,
              ),
            ),
            prefixIcon: _buildSvgSurfFixIcon(svgPaddingLeft: 15, svgIcon: "assets/icons/Search Icon.svg")
        ),
        onChanged: (value) {
          this.onChange(value);
        }
    );
  }

  Widget _buildSvgSurfFixIcon( {
    double svgPaddingLeft,
    String svgIcon
  }) {
    double left = 0;
    if(svgPaddingLeft != null) {
      left = svgPaddingLeft;
    }
    return Padding(
      padding: EdgeInsets.fromLTRB( left,10,10,10),
      child: SvgPicture.asset(
          svgIcon,
          color: Colors.white,
          height: getProportionateScreenWidth(19)
      ),
    );
  }
}
