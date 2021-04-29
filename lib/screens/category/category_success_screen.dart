import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widget/category_success_body.dart';

class CategorySuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Login Success"),
      ),
      body: CategorySuccessBody(),
    );
  }
}
