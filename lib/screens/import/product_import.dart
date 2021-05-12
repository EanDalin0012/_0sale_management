import 'package:flutter/material.dart';

class ProductImportBody extends StatefulWidget {
  const ProductImportBody({Key key}) : super(key: key);

  @override
  _ProductImportBodyState createState() => _ProductImportBodyState();
}

class _ProductImportBodyState extends State<ProductImportBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffeeee00),
      height: 800.0,
      alignment: Alignment.center,
      child: const Text('Fixed Height Content'),
    );
  }
}
