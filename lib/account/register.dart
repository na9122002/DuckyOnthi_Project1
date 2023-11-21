import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travo_app_source/account/login.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/representation/BottomNavigationBar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = 'register';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController em = TextEditingController();
  TextEditingController pas = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController ComfirmPas = TextEditingController();
  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: em.text.trim(),
      password: pas.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
        title: Text('Đăng kí tài khoản'),
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Color.fromRGBO(255, 189, 189, 1),
        child: Stack(children: [
          Positioned(child: Image.asset(AssetHelper.dangki)),
          Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 350,
                ),
                TextField(
                  controller: username,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập Tên đăng nhập',
                    fillColor: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                    TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                        text: newValue.text.replaceAll('.', ','),
                      ),
                    ),
                  ],
                  controller: phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập số điện thoại',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: em,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập Email',
                    fillColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: pas,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mật khẩu',
                    fillColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: ComfirmPas,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập lại mật khẩu',
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
                    child: Text('Đăng kí',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    onPressed: () async {
                      String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                      var regExp = new RegExp(regexPattern);
                      final bool isValid =
                          EmailValidator.validate(em.text.trim());
                      if (!isValid) {
                        Fluttertoast.showToast(
                          msg: 'Vui lòng nhập đúng email',
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(255, 7, 6, 6),
                        );
                      } else if (!regExp.hasMatch(phone.text)) {
                        Fluttertoast.showToast(
                          msg: 'Vui lòng nhập đúng Số điênj thoại',
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(255, 7, 6, 6),
                        );
                      } else if (pas.text.length < 10) {
                        Fluttertoast.showToast(
                          msg: 'Mật khẩu nhập phải đủ ít nhất 10 kí tự ',
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(255, 7, 6, 6),
                        );
                      } else if (em.text == "" ||
                          phone.text == "" ||
                          pas.text == "" ||
                          username == "") {
                        Fluttertoast.showToast(
                          msg:
                              'Đăng kí thất bại vui lòng điền đầy đủ thông  tin',
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(255, 7, 6, 6),
                        );
                      } else if (pas.text != ComfirmPas.text) {
                        Fluttertoast.showToast(
                          msg: 'Vui lòng xem lại mật khẩu đăng nhập',
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(255, 7, 7, 7),
                        );
                      } else {
                        signUp();
                        createUser();
                        Fluttertoast.showToast(
                          msg: 'Đăng kí thành công',
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(255, 7, 7, 7),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future createUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = User(
      id: docUser.id,
      TenDangNhap: username.text,
      Sodienthoai: phone.text,
      email: em.text,
      MatKhau: pas.text,
    );
    final json = user.toJson();
    await docUser.set(json);
  }
}

class User {
  String id;
  final String TenDangNhap;
  final String Sodienthoai;
  final String email;
  final String MatKhau;
  User({
    this.id = '',
    required this.TenDangNhap,
    required this.Sodienthoai,
    required this.email,
    required this.MatKhau,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'TenDangNhap': TenDangNhap,
        'Sodienthoai': Sodienthoai,
        'email': email,
        'Matkhau': MatKhau,
      };

  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      TenDangNhap: json['TenDangNhap'],
      Sodienthoai: json['Sodienthoai'],
      email: json['email'],
      MatKhau: json['Matkhau']);
}
