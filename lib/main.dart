import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sale_management/screens/choose_language/choose_language.dart';
import 'package:sale_management/screens/sign_in/sign_in_screen.dart';
import 'package:sale_management/screens/theme.dart';
import 'package:sale_management/screens/widgets/country_dropdown/provider/country_provider.dart';
import 'package:sale_management/share/database/language_db.dart';
import 'package:sale_management/share/model/key/language_key.dart';
import 'package:sale_management/share/static/language_static.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map currentLanguage;

  @override
  void initState() {
    LanguageDataBase.currentSelectedLanguage().then((value) {
      if (value != null) {
        print('found data'+ value.toString());
        setState(() {
          currentLanguage = value;
          MemoryStore.languageStore = currentLanguage;
        });
      } else {
        print('not found data');
      }
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => CountryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        home: currentLanguage == null ? ChooseLanguageScreen() : SignInScreen(),
      )
  );

  void checkCurrentLanguage() {

  }
}


class MyAppa extends StatelessWidget {
  // This widget is the root of your application.
  Map currentLanguage;
  MyApp() {
    LanguageDataBase.currentSelectedLanguage().then((value) {
      if (value != null) {
        print('not found data');
        currentLanguage = value;
      } else {
        print('not found data');
      }
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => CountryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        home: currentLanguage == null ? ChooseLanguageScreen() : SignInScreen(),
      )
  );

}
