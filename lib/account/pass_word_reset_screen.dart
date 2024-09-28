import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);
  static const routeName = 'PasswordScreen';
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController em = TextEditingController();
  TextEditingController pas = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController username = TextEditingController();
  @override
  void dispose() {
    em.dispose();
    super.dispose();
  }

  Future PasswordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: em.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                content:
                    Text('Đăng xác nhận ! Xin vui lòng kiểm tra lại email'));
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                content: Text('Vui lòng kiểm tra lại !email chưa chính xác'));
          });
    }
  }

  Widget build(BuildContext context) {
    // _readData() async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setStringList(
    //       'items', <String>[em.text, username.text, phone.text, pas.text]);
    // }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
        title: Text(
          'Thiết lập lại mật khẩu',
          style: TextStyle(color: Colors.black),
        ),
      ),
      //for the form to be in center
      body: Container(
        color: Color.fromRGBO(255, 189, 189, 1),
        child: Stack(children: [
          Positioned(child: Image.asset(AssetHelper.matkhau)),
          Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 350,
                ),
                TextField(
                  controller: em,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập tên Email đã đăng kí',
                    fillColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 100, right: 100),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 6, 5, 5)),
                      left: BorderSide(
                          width: 1, color: Color.fromARGB(255, 10, 10, 10)),
                      right: BorderSide(width: 1, color: Color(0xFFFF000000)),
                      bottom: BorderSide(width: 1, color: Color(0xFFFF000000)),
                    ),
                  ),
                  child: TextButton(
                    child: Text('Cài lại mật khẩu',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1))),
                    onPressed: PasswordReset,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}