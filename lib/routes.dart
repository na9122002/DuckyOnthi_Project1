import 'package:flutter/material.dart';
import 'package:travo_app_source/screens/users/users_screen.dart';
import 'package:travo_app_source/screens/account/login_screen.dart';
import 'package:travo_app_source/screens/account/register_screen.dart';

import 'package:travo_app_source/screens/representation/Home_Screen.dart';
import 'package:travo_app_source/screens/representation/home_screen2.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  AppBarContainerWidget.routeName: (context) => AppBarContainerWidget(),
  UserScreen.routeName: (context) => UserScreen(),
};
