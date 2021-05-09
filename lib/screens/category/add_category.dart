import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widget/add_new_category_form.dart';

class AddNewCategoryScreen extends StatefulWidget {

  @override
  _AddNewCategoryScreenState createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Category"),
      ),
      body: SafeArea(
        child: AddNewCategoryForm(),
      ),
    );
  }
}
