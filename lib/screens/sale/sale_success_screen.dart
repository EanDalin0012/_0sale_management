import 'package:flutter/material.dart';
import 'package:sale_management/screens/sale/widgets/sale_success_body.dart';

class SaleSuccessScreen extends StatelessWidget {
  final bool isAddScreen;
  final bool isEditScreen;
  final Map vData;

  SaleSuccessScreen({
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
      body: SaleSuccessBody(vData: this.vData,isAddScreen: this.isAddScreen,isEditScreen: this.isEditScreen,),
    );
  }
}
