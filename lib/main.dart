import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sale_management/screens/choose_language/choose_language.dart';
import 'package:sale_management/screens/sign_in/sign_in_screen.dart';
import 'package:sale_management/screens/theme.dart';
import 'package:sale_management/screens/widgets/country_dropdown/provider/country_provider.dart';
import 'package:sale_management/share/database/language_db.dart';
import 'package:sale_management/share/static/language_static.dart';
import 'package:easy_localization/easy_localization.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(EasyLocalization(
    path: 'assets/i18n',
    supportedLocales: [
      Locale('en'),
      Locale('km'),
    ],
    fallbackLocale: Locale('en'),
    saveLocale: true,
    //assetLoader: CodegenLoader(),
    child: MyApp(),
  )

  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map currentLanguage;

  // @override
  // void initState() {
  //   LanguageDataBase.currentSelectedLanguage().then((value) {
  //     if (value != null) {
  //       setState(() {
  //         currentLanguage = value;
  //         MemoryStore.languageStore = currentLanguage;
  //       });
  //     } else {
  //       print('not found data');
  //     }
  //   });
  //
  //
  // }

  showMessage({String data}) {
    return AlertDialog(
        title: Text(data.toString())
    );
    // _showToast();

  }

  @override
  Widget build(BuildContext context) {
    //context.locale = Locale('en', 'US');
    //var _newLocale = Locale('en', 'en');
    // context.setLocale(_newLocale); // change `easy_localization` locale

    print(context.locale.toString());
    print(context.locale.toString());
    print('${'title'.tr()}'); //String
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: SignInScreen(),
    );

    void checkCurrentLanguage() {

    }
  }

  // Widget build1(BuildContext context) {
  //   //Toast.show('show language:'+MemoryStore.languageStore.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  //   return ChangeNotifierProvider(
  //       create: (context) => CountryProvider(),
  //       child: MaterialApp(
  //         debugShowCheckedModeBanner: false,
  //         title: 'Flutter Demo',
  //         theme: theme(),
  //         home: currentLanguage == null ? ChooseLanguageScreen() : SignInScreen(),
  //       )
  //   );
  //
  //   void checkCurrentLanguage() {
  //
  //   }
  // }

}
