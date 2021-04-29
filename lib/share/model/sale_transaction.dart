import 'package:flutter/material.dart';

class SaleTransactionModel {
  final int id;
  final String transactionId;
  final num total;
  final String transactionDate;
  final String remark;

  SaleTransactionModel({
    @required this.id,
    @required this.transactionId,
    @required this.total,
    @required this.transactionDate,
    this.remark,
  });

  factory SaleTransactionModel.fromJson(Map<String, dynamic> json) {
    return SaleTransactionModel(
      id: json['id'],
      transactionId: json['transactionId'],
      total: json['total'],
      transactionDate: json['transactionDate'],
      remark: json['remark'],
    );
  }


    @override
    String toString() {
      return 'SaleTransactionModel: {id: $id, transactionId: $transactionId, total: $total, transactionData: $transactionDate, remark: $remark}';
    }
}
