import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widget/category_success_body.dart';

class CategorySuccessScreen extends StatelessWidget {
  final bool isAddScreen;
  final bool isEditScreen;
  final Map vData;

  CategorySuccessScreen({
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
      body: CategorySuccessBody(vData: this.vData,isAddScreen: this.isAddScreen,isEditScreen: this.isEditScreen,),
    );
  }
}
