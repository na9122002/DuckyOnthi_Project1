import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/group_chat/history_chat/history_chat_appbar.dart';
import 'package:travo_app_source/screens/group_chat/history_chat/history_chat_body.dart';
import 'package:travo_app_source/screens/group_chat/main_group_chat/main_group_chat.dart';
import 'package:travo_app_source/screens/group_chat/question_comment/question_comment.dart';

class HistoryChatSceen extends StatefulWidget {
  const HistoryChatSceen({Key? key}) : super(key: key);
  @override
  State<HistoryChatSceen> createState() => _HistoryChatSceenState();
}

String IDUser1 = '';
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

futureInt() async {
  final Users1 = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: '${Users1?.email}')
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
            IDUser1 = document.reference.id;
          }));
}

class _HistoryChatSceenState extends State<HistoryChatSceen> {
  String dropdownValue = list.first;
  Widget build(BuildContext context) {
    dynamic docIDPost;
    SampleItem? selectedMenu;
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final Users1 = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users1?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              IDUser1 = document.reference.id;
            }));
    return Scaffold(
      appBar: HistoryChatAppbar(),
      body: HistroryChatBody(docIDPost: docIDPost,list: list,selectedMenu: selectedMenu,dropdownValue: dropdownValue,),
    );
  }
}
