import 'package:flutter/material.dart';
import 'package:sale_management/screens/package_product/widgets/success_body.dart';
import 'package:sale_management/share/constant/text_style.dart';

class SuccessScreen extends StatelessWidget {
  final bool isAddScreen;
  final bool isEditScreen;
  SuccessScreen({Key key,this.isAddScreen, this.isEditScreen}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Success", style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500)),
      ),
      body: SuccessBody(isAddScreen: this.isAddScreen, isEditScreen: this.isEditScreen),
    );
  }
}
