import 'package:flutter/material.dart';
import 'package:travo_app_source/temporary_unused_file/biology/json_biology.dart';

class Biology12Screen extends StatefulWidget {
  const Biology12Screen({Key? key}) : super(key: key);
  static const routeName = 'english12_screen';
  @override
  State<Biology12Screen> createState() => _Biology12ScreenState();
}

_Ontap(dynamic topic, dynamic context) {
  // Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) =>
  //             QuesionNormalModel(topic: topic, subject: 'Sinh Học')));
}

class _Biology12ScreenState extends State<Biology12Screen> {
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
                    _Ontap(BiologyTopic1, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 2',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(BiologyTopic2, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 3',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(BiologyTopic3, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 4',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(BiologyTopic4, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 5',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(BiologyTopic5, context);
                  }),
              ListTile(
                  title: Text(
                    'Đề 6',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _Ontap(BiologyTopic6, context);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
