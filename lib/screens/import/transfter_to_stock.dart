import 'package:flutter/material.dart';
import 'package:sale_management/screens/import/widget/transfer_to_stock_body.dart';

class TransferToStock extends StatefulWidget {
  final Map vImport;
  const TransferToStock({Key key, this.vImport}) : super(key: key);

  @override
  _TransferToStockState createState() => _TransferToStockState();
}

class _TransferToStockState extends State<TransferToStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Transfer"),
      ),
      body: SafeArea(
        child: TransferToStockBody(vImport: widget.vImport),
      ),
    );
  }

}
