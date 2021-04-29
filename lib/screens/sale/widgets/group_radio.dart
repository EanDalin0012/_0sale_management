import 'package:flutter/material.dart';

class GroupRadio extends StatelessWidget {
  List<dynamic> vData = [];

  @override
  Widget build(BuildContext context) {
    this.vData = [
      {
        'text': 'Andorid',
        'index': 1,
        'selected': true
      },
      {
        'text': 'IOS',
        'index': 2,
        'selected': false
      }
    ];
    return Container();
  }
}
