import 'package:flutter/material.dart';
import 'package:sale_management/screens/product/widget/product_form_edit.dart';

class EditProductScreen extends StatefulWidget {
  final Map product;
  EditProductScreen({this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text("Product"),
        ),
        body: SafeArea(
          child:  ProductFormEdit(productItem: widget.product),
        )
    );
  }
}


