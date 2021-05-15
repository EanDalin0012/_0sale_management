import 'package:flutter/material.dart';
import 'package:sale_management/screens/stock/widget/view_stock_body.dart';

class ViewStockScreen extends StatelessWidget {
  final Map vData;
  const ViewStockScreen({Key key, this.vData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Stock"),
      ),
      body: SafeArea(
          child: ViewStockBody(vData: this.vData)
      ),
    );
  }
}
