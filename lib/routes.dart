import 'package:flutter/material.dart';
import 'package:travo_app_source/EnglishClassUnivercity/english12_screen.dart';
import 'package:travo_app_source/Users/SettingScreen.dart';
import 'package:travo_app_source/Users/UsersScreen.dart';
import 'package:travo_app_source/account/login.dart';
import 'package:travo_app_source/account/register.dart';
import 'package:travo_app_source/representation/Home_Screen.dart';
import 'package:travo_app_source/representation/BottomNavigationBar.dart';
import 'package:travo_app_source/representation/home_screen2.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  English12Screen.routeName: (context) => const English12Screen(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  AppBarContainerWidget.routeName: (context) => AppBarContainerWidget(),
  UserScreen.routeName: (context) => UserScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
};
