import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/group_chat/creat_question/creat_question.dart';
import 'package:travo_app_source/screens/group_chat/history_chat/history_chat.dart';
import 'package:travo_app_source/screens/group_chat/main_group_chat/main_group_chat_appbar.dart';
import 'package:travo_app_source/screens/group_chat/main_group_chat/main_group_chat_body.dart';

import 'package:travo_app_source/screens/group_chat/question_comment/question_comment.dart';
import 'package:travo_app_source/models/users_model.dart' as users_model;

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({Key? key}) : super(key: key);
  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

List<String> list = <String>[
  'Toán',
  'Tiếng Anh',
  'Ngữ Văn',
  'Lịch Sử',
  'Đại Lý',
  'Vật Lý',
  'Hóa Học',
  'Sinh Học',
  'Công Dân'
];

enum SampleItem { itemOne }

dynamic DocumentIDcomment = [];

class _MainChatScreenState extends State<MainChatScreen> {
  bool isLiked = false;
  int likeCount = 17;
  dynamic docIDPost;
  SampleItem? selectedMenu;
  String numberquestion = '';
  String UserName = '';
  String dropdownValue = list.first;
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    TextStyle styleList = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
    readUser();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: MainGroupChatAppbar(
        UserName: UserName,
      ),
      body: MainGroupChatBody(
        docIDPost: docIDPost,
        selectedMenu: selectedMenu,
        dropdownValue: dropdownValue,
      ),
    );
  }

  readUser() async {
    final Users = FirebaseAuth.instance.currentUser;

    if (Users == null) {
      print("No user is logged in");
      return;
    }

    try {
      // Truy vấn để lấy docID của người dùng
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: Users.email)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No user found with the provided email");
        return;
      }

      // Lấy docID của người dùng
      final docID = snapshot.docs.first.id;

      // Truy xuất dữ liệu người dùng từ Firestore
      final docUser = FirebaseFirestore.instance.collection('users').doc(docID);
      final snapshot2 = await docUser.get();

      if (!snapshot2.exists) {
        print("User document not found");
        return;
      }

      // Lấy dữ liệu người dùng từ snapshot
      final userData = snapshot2.data();
      if (userData != null) {
        setState(() {
          // Đảm bảo rằng dữ liệu có tồn tại trước khi sử dụng
          UserName = users_model.User.fromJson(userData).username;
        });
      } else {
        print("No user data available");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}
