import 'package:flutter/foundation.dart';

class PackageProductModel {
  final int id;
  final String name;
  final int productId;
  final int quantity;
  final num price;
  final String remark;

  const PackageProductModel({
    @required this.id,
    @required this.name,
    @required  this.productId,
    @required  this.quantity,
    @required  this.price,
    @required  this.remark
  });

  factory PackageProductModel.fromJson(Map<String, dynamic> json) {
    return PackageProductModel(
      id: json['id'],
      name: json['name'],
      productId: json['productId'],
      quantity: json['quantity'],
      price: json['price'],
      remark: json['remark'],
    );
  }

  @override
  String toString() {
    return 'PackageProductModel : {id: $id, name: $name, productId: $productId, quantity: $quantity, price: $price, remark: $remark}';
  }
}
