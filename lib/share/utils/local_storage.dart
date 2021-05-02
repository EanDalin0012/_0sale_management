
import 'package:shared_preferences/shared_preferences.dart';

class UtilLocalStorage {

  static set({String key, String value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static Future<String> get({String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.get(key);
    print('data : ${data}');
    return pref.get(key);
  }

}
