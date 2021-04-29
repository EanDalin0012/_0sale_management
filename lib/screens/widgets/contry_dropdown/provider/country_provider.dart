import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/share/model/country.dart';
import 'package:sale_management/share/utils/utils.dart';

class CountryProvider with ChangeNotifier {
  CountryProvider() {
    loadCountries().then((countries) {
      _countries = countries;
      notifyListeners();
    });
  }

  List<CountryModel> _countries = [];

  List<CountryModel> get countries => _countries;

  Future loadCountries() async {
    final data = await rootBundle.loadString('assets/json_data/country_codes.json');
    final countriesJson = json.decode(data);
    return countriesJson.keys.map<CountryModel>((code) {
      final json = countriesJson[code];
      final newJson = json..addAll({'code': code.toLowerCase()});
      return CountryModel.fromJson(newJson);
    }).toList()
      ..sort(Utils.ascendingSort);
  }
}
