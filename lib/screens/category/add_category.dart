import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widget/add_new_category_body.dart';

class AddNewCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Category"),
      ),
      body: AddNewCategoryBody(),
    );
  }
}
