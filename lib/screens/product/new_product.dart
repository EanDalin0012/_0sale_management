import 'package:flutter/material.dart';
import 'package:sale_management/screens/product/widget/new_product_body.dart';

class NewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Product"),
      ),
      body: NewProductBody(),
    );
  }
}
