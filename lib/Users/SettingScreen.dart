import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travo_app_source/LightAndDark.dart/change_theme_button_widget.dart';
import 'package:travo_app_source/LightAndDark.dart/theme_provider.dart';
import 'package:travo_app_source/MathUnivercity/readData.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/notUpdate.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String routeName = "SettingScreen";
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool light1 = true;
  bool light2 = true;
  _notUpDate(String function) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OthersubjectScreen(
                  subject: function,
                )));
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                AssetHelper.Image_Text_Setting,
                height: height / 4,
                width: width,
                fit: BoxFit.fill,
              ),
              Container(
                  height: height / 4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: Colors.grey),
                      left: BorderSide(width: 1, color: Colors.grey),
                      right: BorderSide(width: 1, color: Colors.grey),
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  child: Text('Cài đặt',
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Colors.grey),
                left: BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: Text(
                'Giờ ôn tập',
                style: TextStyle(fontSize: 25),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                _notUpDate('Giờ ôn tập');
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Colors.grey),
                left: BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: Text(
                'Giao diện tối',
                style: TextStyle(fontSize: 25),
              ),
              trailing: ChangeThemeButtonWidget(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Colors.grey),
                left: BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: Text(
                'Thông báo',
                style: TextStyle(fontSize: 25),
              ),
              trailing: Switch(
                value: light2,
                activeColor: Color.fromRGBO(255, 189, 189, 1),
                onChanged: (bool value) {
                  light2 = value;
                },
              ),
              onTap: () {
                // parseData();
                _notUpDate('Thông báo');
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Colors.grey),
                left: BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: Text(
                'Đánh giá',
                style: TextStyle(fontSize: 25),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                //parseData();
                _notUpDate('Đánh giá');
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Colors.grey),
                left: BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: Text(
                'Chia sẻ ứng dụng',
                style: TextStyle(fontSize: 25),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                _notUpDate('Chia sẻ ứng dụng');
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Colors.grey),
                left: BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: Text(
                'Điều khoản sử dụng',
                style: TextStyle(fontSize: 25),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                _notUpDate('Điều khoản sử dụng');
              },
            ),
          ),
        ],
      ),
    );
  }
}
