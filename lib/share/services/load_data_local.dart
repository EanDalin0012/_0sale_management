import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sale_management/share/model/package_product.dart';

class LoadLocalData {

  static Future<List<dynamic>> fetchProductItems() async {
      final data = await rootBundle.loadString('assets/json_data/product_list.json');
      Map valueMap = jsonDecode(data);
      var products = valueMap['products'];
     return products;
  }

  static Future<List<PackageProductModel>> fetchPackageProductItems() async {
    final data = await rootBundle.loadString('assets/json_data/package_of_product_list.json');
    Map valueMap = jsonDecode(data);
    var dataItems = valueMap['packageProducts'];
    var arrObjs = dataItems.map<PackageProductModel>((json) {
      return PackageProductModel.fromJson(json);
    }).toList();
    print('data item ${arrObjs.toString()}');
    return dataItems;
  }

}
