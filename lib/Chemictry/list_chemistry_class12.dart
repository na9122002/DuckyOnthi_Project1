import 'package:flutter/material.dart';
import 'package:travo_app_source/chemictry/json_chemictry.dart';
import 'package:travo_app_source/screens/do_and_review_questions/question_model_normal.dart';

class Chemistry12Screen extends StatefulWidget {
  const Chemistry12Screen({Key? key}) : super(key: key);
  static const routeName = 'english12_screen';
  @override
  State<Chemistry12Screen> createState() => _Chemistry12ScreenState();
}

_Ontap(dynamic topic, dynamic context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              QuesionNormalModel(topic: topic, subject: 'Hóa Học')));
}

class _Chemistry12ScreenState extends State<Chemistry12Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Hóa học THPT quốc gia',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              ListTile(
                  title: Text(
                    'Đề 1',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic1, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 2',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic2, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 3',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic3, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 4',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic4, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 5',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic5, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 6',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic6, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 7',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic7, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 8',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic8, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 9',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic9, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 10',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(ChemistryTopic10, context);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
