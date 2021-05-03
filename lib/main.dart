import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sale_management/screens/sign_in/sign_in_screen.dart';
import 'package:sale_management/screens/theme.dart';
import 'package:sale_management/screens/widgets/country_dropdown/provider/country_provider.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/utils/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Map vData = {
    LanguageKey.code: 'en',
    LanguageKey.value: 'English',
  };
  UtilLocalStorage.set(key: 'lang', info: vData);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => CountryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        home: SignInScreen(),
      )
  );
}
