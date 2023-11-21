import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:travo_app_source/LightAndDark.dart/ColorConstWidget.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.black,
      cardColor: Colors.black,
      highlightColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
      colorScheme: const ColorScheme.dark()
          .copyWith(primary: Colors.black, secondary: Colors.white),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.blueGrey[100]));

  static final lightTheme = ThemeData(
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: ColorConst.backgroundScaffoldColor,
      primaryColor: ColorConst.colorBlack,
      cardColor: ColorConst.colorBackgroundGray,
      highlightColor: Colors.black12,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorConst.colorPrimaryTextLight, //thereby
        selectionColor:
            ColorConst.colorPrimaryTextLight.withOpacity(0.2), //thereby
        selectionHandleColor: ColorConst.colorPrimaryTextLight, //thereby
      ),
      iconTheme:
          const IconThemeData(color: ColorConst.colorPrimary, opacity: 0.8),
      // colorScheme:
      //     const ColorScheme.light().copyWith(secondary: Colors.blueGrey[800]),
      colorScheme: const ColorScheme.light().copyWith(
          primary: ColorConst.colorPrimary, secondary: Colors.blue[500]),
      textTheme: const TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: ColorConst.colorTextStory,
        displayColor: ColorConst.colorTextStory,
      ),
      primaryTextTheme: const TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: ColorConst.colorPrimaryTextLight,
        displayColor: ColorConst.colorPrimaryTextLight,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.blue[400]));
}
