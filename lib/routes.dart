import 'package:flutter/material.dart';
import 'package:travo_app_source/screens/Users/setting_screen.dart';
import 'package:travo_app_source/screens/Users/users_screen.dart';
import 'package:travo_app_source/account/login_screen.dart';
import 'package:travo_app_source/account/register_screen.dart';
import 'package:travo_app_source/screens/english12_screen.dart';
import 'package:travo_app_source/screens/representation/Home_Screen.dart';
import 'package:travo_app_source/screens/representation/home_screen2.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  English12Screen.routeName: (context) => const English12Screen(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  AppBarContainerWidget.routeName: (context) => AppBarContainerWidget(),
  UserScreen.routeName: (context) => UserScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
};
