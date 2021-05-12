import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductImportBody extends StatefulWidget {
  const ProductImportBody({Key key}) : super(key: key);

  @override
  _ProductImportBodyState createState() => _ProductImportBodyState();
}

class _ProductImportBodyState extends State<ProductImportBody> {

  List<dynamic> vData = [];

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffeeee00),
      child: _buildBody()
    );
  }

  Widget _buildBody() {
    return ListView.separated(
      itemCount: vData.length,
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/product_imports.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['imports'];
    });
    return this.vData;
  }
}
