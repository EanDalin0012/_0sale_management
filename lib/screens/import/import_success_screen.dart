import 'package:flutter/material.dart';
import 'package:sale_management/screens/import/widget/import_success_body.dart';

class ImportSuccessScreen extends StatelessWidget {
  final bool isAddScreen;
  final bool isEditScreen;
  final Map vData;

  ImportSuccessScreen({
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
      body: ImportSuccessBody(vData: this.vData,isAddScreen: this.isAddScreen,isEditScreen: this.isEditScreen,),
    );
  }
}
