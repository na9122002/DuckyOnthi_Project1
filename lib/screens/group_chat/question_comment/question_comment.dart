import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/models/question_and_comment.dart';
import 'package:travo_app_source/screens/group_chat/main_group_chat/main_group_chat.dart';
import 'package:travo_app_source/screens/group_chat/question_comment/question_comment_appbar.dart';
import 'package:travo_app_source/screens/group_chat/question_comment/question_comment_body.dart';
import 'package:travo_app_source/screens/group_chat/question_comment/question_comment_bottom.dart';
import 'package:travo_app_source/screens/representation/bottom_navigation_bar.dart';

class QuestionAndComentScreen extends StatefulWidget {
  const QuestionAndComentScreen({
    Key? key,
    required this.content,
    required this.image,
    required this.dropdownValue,
    required this.IDquestion,
    required this.userNamePost,
    required this.timeShow,
    required this.IDUser,
  }) : super(key: key);
  final String content;
  final List<dynamic> image;
  final String dropdownValue;
  final String IDquestion;
  final String userNamePost;
  final String timeShow;
  final String IDUser;
  @override
  State<QuestionAndComentScreen> createState() =>
      _QuestionAndComentScreenState();
}

class _QuestionAndComentScreenState extends State<QuestionAndComentScreen> {
  SampleItem? selectedMenu;
  TextEditingController comment = TextEditingController();
  DateTime TimeChat = DateTime.now();
  String imageUrl = '';
  TextStyle styleList = TextStyle(fontSize: 20);
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    List<dynamic> ListImage = [];
    for (int i = 0; i < widget.image.length; i++) ListImage.add(i);
    return Scaffold(
        appBar: QuestionCommentAppbar(),
        body: QuestionCommentBody(
          IDUser: widget.IDUser,
          IDquestion: widget.IDquestion,
          content: widget.content,
          dropdownValue: widget.dropdownValue,
          image: widget.image,
          timeShow: widget.timeShow,
          selectedMenu: selectedMenu,
          userNamePost: widget.userNamePost,
        ),
        bottomNavigationBar: QuestionCommentBottom(
          imageUrl: imageUrl,
          dropdownValue: widget.dropdownValue,
          IDquestion: widget.IDquestion,
          TimeChat: TimeChat,
          comment: comment,
        ));
  }

  Future createComent(dynamic snapshot) async {
    dynamic docIDs;
    final Users = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs = document.reference.id;
            }));
    final docUser = FirebaseFirestore.instance.collection('users').doc(docIDs);
    final snapshot1 = await docUser.get();

    final _user = QuestionAndComment.QuestionAndComment(
      comment: comment.text,
      image: imageUrl,
      time: TimeChat.toString(),
      userName: User1.fromJson(snapshot1.data()!).TenDangNhap,
      IDuser: docIDs,
      ShowTime: formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]),
    );
    final json = _user.toJson();

    FirebaseFirestore.instance
        .collection('_Group_Chat')
        .doc('${widget.dropdownValue}')
        .collection('Question_Chat')
        .doc('${widget.IDquestion}')
        .collection('comment')
        .doc()
        .set(json);
  }
}

class User1 {
  String id;
  final String TenDangNhap;
  final String Sodienthoai;
  final String email;
  final String MatKhau;

  User1({
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

  static User1 fromJson(Map<String, dynamic> json) => User1(
      id: json['id'],
      TenDangNhap: json['TenDangNhap'],
      Sodienthoai: json['Sodienthoai'],
      email: json['email'],
      MatKhau: json['Matkhau']);
}
