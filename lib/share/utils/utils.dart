
import 'package:sale_management/share/model/country.dart';

class Utils {
  static int ascendingSort(CountryModel c1, CountryModel c2) =>
      c1.name.compareTo(c2.name);
}
