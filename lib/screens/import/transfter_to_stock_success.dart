import 'package:flutter/material.dart';
import 'package:sale_management/screens/import/widget/transfer_to_stock_success_body.dart';

class TransferToStockSuccessScreen extends StatelessWidget {
  final Map vData;
  const TransferToStockSuccessScreen({Key key, this.vData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Success"),
      ),
      body: TransferToStockSuccessBody(vData: this.vData),
    );
  }
}
