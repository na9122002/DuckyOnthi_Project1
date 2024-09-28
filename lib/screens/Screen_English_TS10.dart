import 'package:flutter/material.dart';
import 'package:travo_app_source/english_class10/list_quesion_english10.dart';
import 'package:travo_app_source/screens/do_and_review_questions/question_model_normal.dart';

class English10Screen extends StatefulWidget {
  const English10Screen({Key? key}) : super(key: key);
  static const routeName = 'Screen_English_TS10';
  @override
  State<English10Screen> createState() => _English10ScreenState();
}

_Ontap(dynamic topic, dynamic context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              QuesionNormalModel(topic: topic, subject: 'Tiếng Anh')));
}

class _English10ScreenState extends State<English10Screen> {
  TextStyle heading3 = TextStyle(fontSize: 25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Tiếng Anh vào lớp 10',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
      ),
      // Implement the ExpansionTile
      body: Container(
        child: Column(
          children: [
            ListTile(
                title: Text(
                  'Đề 1',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic1, context);
                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 2',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic2, context);

                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 3',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic3, context);

                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 4',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic4, context);

                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 5',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic5, context);

                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 6',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic6, context);

                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 7',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic7, context);

                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 8',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic8, context);

                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 9',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic9, context);

                  //QuestionMath11Screen();
                }),
            ListTile(
                title: Text(
                  'Đề 10',
                  style: heading3,
                ),
                onTap: () {
                  _Ontap(E10toppic10, context);

                  //QuestionMath11Screen();
                }),
          ],
        ),
      ),
    );
  }
}
