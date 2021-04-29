import 'package:flutter/material.dart';

class DropdownContainer extends StatelessWidget {
  final Widget child;
  const DropdownContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
          left: 15,
          right: 15
      ),
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(color: Colors.deepPurple, width: 1.5),
      ),
      child: child,
    );
  }
}
