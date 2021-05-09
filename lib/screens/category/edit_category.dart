import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widget/edit_category_form.dart';

class EditCategoryScreen extends StatefulWidget {
  final Map category;
  EditCategoryScreen({
    @required this.category
});

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text("Category"),
        ),
        body: SafeArea(
          child: EditCategoryForm(category: widget.category),
        )
    );
  }

}
