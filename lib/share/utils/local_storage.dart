

import 'package:localstorage/localstorage.dart';

class UtilLocalStorage {

  static String localstorageApp = 'localstorage_app';
  static LocalStorage storage = new LocalStorage(localstorageApp);
  static set({String key, Map info})  {
    storage.setItem(key, info);
  }

  static Map get({String key})  {
    Map vData = storage.getItem(key);
    print('vData: ${vData}');
    return vData;
  }

}
