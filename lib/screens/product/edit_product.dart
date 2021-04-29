import 'package:flutter/material.dart';
import 'package:sale_management/screens/product/widget/edit_product_body.dart';

class EditProduct extends StatelessWidget {
  final Map productItem;
  EditProduct({this.productItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Product"),
      ),
      body: EditProductBody(productItem: productItem,),
    );
  }
}
