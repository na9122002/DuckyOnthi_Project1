import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travo_app_source/screens/account/pass_word_reset_screen.dart';
import 'package:travo_app_source/screens/account/register_screen.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/widget/custom_login_button.dart';
import 'package:travo_app_source/widget/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController em = TextEditingController();
  TextEditingController pas = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool Login = false;
    return Container(
        child: Stack(children: [
      Positioned(child: Image.asset(AssetHelper.dangnhap)),
      Container(
        alignment: Alignment.bottomCenter,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 45.0),
            CustomTextfield(
              controller: em,
              hintText: 'Nhập Email',
            ),
            SizedBox(height: 10.0),
            CustomTextfield(controller: pas, hintText: 'Nhập mật khẩu'),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordScreen()));
                  },
                  child: const Text('Quên mật khẩu',
                      style: TextStyle(
                          color: Color.fromARGB(255, 239, 73, 73),
                          fontSize: 18))),
            ),
            SizedBox(height: 5.0),
            CustomLoginButton(
              label: 'Đăng nhập',
              onPressed: () async {
                if (em.text == "" || pas.text == "") {
                  Fluttertoast.showToast(
                    msg: 'Vui lòng nhập đầy đủ thông tin',
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 3, 2, 2),
                  );
                } else {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: em.text.trim(), password: pas.text.trim());
                    Fluttertoast.showToast(
                      msg: 'Đăng nhập thành công',
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 3, 2, 2),
                    );
                  } on FirebaseAuthException catch (e) {
                    Fluttertoast.showToast(
                      msg: 'Vui lòng kiểm tra lại thông tin đăng nhập',
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 3, 2, 2),
                    );
                  }
                  
                }
              },
            ),
            SizedBox(height: 10.0),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Chưa có tài khoản ?',
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: const Text('Đăng kí',
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
          ],
        ),
      ),
    ]));
  }
}
