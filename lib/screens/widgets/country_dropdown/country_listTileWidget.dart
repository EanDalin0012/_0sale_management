
import 'package:flutter/material.dart';
import 'package:sale_management/screens/widgets/country_dropdown/flag_widget.dart';
import 'package:sale_management/share/model/country.dart';

class CountryListTileWidget extends StatelessWidget {
  final CountryModel country;
  final bool isNative;
  final bool isSelected;
  final ValueChanged<CountryModel> onSelectedCountry;

  const CountryListTileWidget({
    Key key,
    @required this.country,
    @required this.isNative,
    @required this.isSelected,
    @required this.onSelectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(
      fontSize: 18,
      color: selectedColor,
      fontWeight: FontWeight.bold,
    )
        : TextStyle(fontSize: 18);

    return ListTile(
      onTap: () => onSelectedCountry(country),
      leading: FlagWidget(code: country.code),
      title: Text(country.name.toString(),
      ),
      trailing: isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
