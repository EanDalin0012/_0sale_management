import 'package:flutter/material.dart';

class ProductModel {
  final int id;
  final String name;
  final String remark;
  final String category;
  final String url;

  const ProductModel({
    @required this.id,
    @required this.name,
    @required  this.remark,
    @required  this.category,
    @required  this.url
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      remark: json['remark'],
      category: json['category'],
      url: json['url'],
    );
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, remark: $remark, category: $category, url: $url}';
  }
}
