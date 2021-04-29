
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_management/screens/widgets/country_dropdown/country_listTileWidget.dart';
import 'package:sale_management/screens/widgets/country_dropdown/provider/country_provider.dart';
import 'package:sale_management/screens/widgets/country_dropdown/search_widget.dart';
import 'package:sale_management/share/model/country.dart';
import 'package:sale_management/share/utils/utils.dart';

class CountryPage extends StatefulWidget {
  final bool isMultiSelection;
  final List<CountryModel> countries;

  const CountryPage({
    Key key,
    this.isMultiSelection = false,
    this.countries = const [],
  }) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  String text = '';
  List<CountryModel> selectedCountries = [];
  bool isNative = false;


  List<CountryModel> getPrioritizedCountries(List<CountryModel> countries) {
    final notSelectedCountries = List.of(countries)
      ..removeWhere((country) => selectedCountries.contains(country));
    return [
      ...List.of(selectedCountries)..sort(Utils.ascendingSort),
      ...notSelectedCountries,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context);
    final allCountries = getPrioritizedCountries(provider.countries);
    final countries = allCountries.where(containsSearchText).toList();

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
            children: allCountries.map((e) {
              final isSelected = selectedCountries.contains(e);
              return CountryListTileWidget(
                country: e,
                isSelected: isSelected,
                isNative: isNative,
                onSelectedCountry: selectCountry,
              );
            }).toList(),
          ),
          )
        ],
      )
    );
  }

  bool containsSearchText(CountryModel country) {
    final name = isNative ? country.nativeName : country.name;
    final textLower = text.toLowerCase();
    final countryLower = name.toLowerCase();

    return countryLower.contains(textLower);
  }

  Widget buildAppBar() {
    final label = widget.isMultiSelection ? 'Countries' : 'Country';

    return AppBar(
      title: Text('Select $label'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.language),
          onPressed: () => setState(() => this.isNative = !isNative),
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(preferredSize: Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'Search $label',
        ),
      ),
    );
  }

  void selectCountry(CountryModel countryModel) {
    if(widget.isMultiSelection) {
      final isSelected = selectedCountries.contains(countryModel);
      setState(() {
        isSelected ? selectedCountries.remove(countryModel) : selectedCountries.add(countryModel);
      });
    } else {
      Navigator.pop(context, countryModel);
    }
  }

}
