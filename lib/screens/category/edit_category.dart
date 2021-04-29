import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widget/edit_category_body.dart';
import 'package:sale_management/share/model/category.dart';

class EditCategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;
  EditCategoryScreen(this.categoryModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Category"),
      ),
      body: EditCategoryBody(categoryModel: categoryModel),
    );
  }
}
