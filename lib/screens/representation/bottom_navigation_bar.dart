import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travo_app_source/screens/Users/users_screen.dart';
import 'package:travo_app_source/account/login_screen.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/group_Chat/Main_Group_Chat.dart';
import 'package:travo_app_source/screens/representation/home_screen2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = 'home_screen';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var size, height, width;
  int _currentIndex = 0;
  String? value;
  String? currentItem;
  Widget Screen3 = LoginPage();
  Widget Screen4 = LoginPage();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 189, 189, 1),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Screen3 = UserScreen();
              Screen4 = MainChatScreen();
            } else if (!snapshot.hasData) {
              Screen3 = LoginPage();
              Screen4 = LoginPage();
            }
            return IndexedStack(
              index: _currentIndex,
              children: [
                HomeScreen(),
                // MainCourseScreen(),
                Screen4,
                Screen3,
                // SettingScreen(),
              ],
            );
          }),
      bottomNavigationBar: Container(
        height: height / 10.35,
        width: width,
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Color.fromARGB(255, 241, 239, 240),
          unselectedItemColor: Color.fromARGB(255, 7, 6, 6),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          items: [
            SalomonBottomBarItem(
              icon: Image.asset(AssetHelper.Icon_Home),
              title: Text(''),
            ),
            SalomonBottomBarItem(
              icon: Image.asset(AssetHelper.Icon_Chat),
              title: Text(''),
            ),
            SalomonBottomBarItem(
              icon: Image.asset(AssetHelper.Icon_User),
              title: Text(''),
            ),
            // SalomonBottomBarItem(
            //   icon: Image.asset(AssetHelper.Icon_Setting),
            //   title: Text(''),
            // ),
          ],
        ),
      ),
    );
  }
}
