import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/representation/bottom_navigation_bar.dart';
import 'package:travo_app_source/models/users_model.dart' as users_model;
import 'package:travo_app_source/widget/custom_login_button.dart';
import 'package:travo_app_source/widget/custom_textfield.dart';

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
                CustomTextfield(
                    controller: username, hintText: 'Nhập tên đăng nhập'),
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
                CustomTextfield(controller: em, hintText: 'Nhập Email'),
                SizedBox(
                  height: 15,
                ),
                CustomTextfield(controller: pas, hintText: 'Nhập mật khẩu'),
                SizedBox(
                  height: 15,
                ),
                CustomTextfield(
                    controller: ComfirmPas, hintText: 'Nhập lại mật khẩu'),
                SizedBox(
                  height: 20,
                ),
                CustomLoginButton(
                    label: 'Đăng kí',
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
                    }),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future createUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = users_model.User(
      id: docUser.id,
      username: username.text,
      mobile: phone.text,
      email: em.text,
      password: pas.text,
    );
    final json = user.toJson();
    await docUser.set(json);
  }
}
