import 'package:flutter/material.dart';

class FlagImageWidget extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final Decoration decoration;
  FlagImageWidget({
    Key key,
    this.width,
    this.height,
    this.decoration,
    @required this.url
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage:NetworkImage(url),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
