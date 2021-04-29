import 'package:flutter/material.dart';

class CountryModel {
  final String name;
  final String nativeName;
  final String code;

  const CountryModel({
    @required this.name,
    @required this.nativeName,
    @required this.code,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    name: json['name'],
    code: json['code'],
    nativeName: json['native'],
  );

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is CountryModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              nativeName == other.nativeName &&
              code == other.code;

  @override
  int get hashCode => name.hashCode ^ nativeName.hashCode ^ code.hashCode;

  @override
  String toString() {
    return 'CountryModel{name: $name, nativeName: $nativeName, code: $code}';
  }
}
