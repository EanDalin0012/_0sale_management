import 'package:flutter/material.dart';
import 'package:sale_management/screens/member/widget/member_success_body.dart';

class MemberSuccessScreen extends StatelessWidget {
  final bool isAddScreen;
  final bool isEditScreen;
  final Map vData;

  MemberSuccessScreen({
    Key key,
    this.isAddScreen,
    this.isEditScreen,
    this.vData
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Success"),
      ),
      body: MemberSuccessBody(vData: this.vData,isAddScreen: this.isAddScreen,isEditScreen: this.isEditScreen,),
    );
  }
}
