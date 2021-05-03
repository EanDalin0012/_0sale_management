

import 'package:localstorage/localstorage.dart';

class UtilLocalStorage {

  static String localstorageApp = 'localstorage_app';
  static LocalStorage storage = new LocalStorage(localstorageApp);
  static set({String key, Map info})  {
    storage.setItem(key, info);
  }

  static Future<Map> get({String key}) async {
    return await storage.getItem(key);
  }

}
