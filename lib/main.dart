import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:travo_app_source/light_and_dark.dart/theme_provider.dart';
import 'package:travo_app_source/routes.dart';
import 'package:travo_app_source/screens/representation/bottom_navigation_bar.dart';
import 'package:travo_app_source/screens/representation/local_storage_helper.dart';
import 'package:travo_app_source/size_config.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  runApp(MyApp());
}

class DefaultFirebaseOptions {
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            darkTheme: MyThemes.darkTheme,
            home: Builder(
              builder: (context) {
                SizeConfig.init(context);
                return HomePage();
              },
            ),
            routes: routes,
          );
        },
      );
}
