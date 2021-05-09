import 'package:flutter/material.dart';
import 'package:sale_management/screens/product/widget/product_form_add.dart';

class NewProductScreen extends StatefulWidget {
  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text("Product"),
        ),
        body: SafeArea(
          child: ProductFormAdd(),
        )
    );
  }
}

