import 'package:flutter/material.dart';
import 'package:travo_app_source/math_univercity/Question_model_Math_Screen.dart';
import 'package:travo_app_source/math_univercity/list_question_math_univercity.dart';

class Math10Screen extends StatefulWidget {
  const Math10Screen({Key? key}) : super(key: key);
  static const routeName = 'List_topic_mathUnvercity_Screen';
  @override
  State<Math10Screen> createState() => _Math10ScreenState();
}

class _Math10ScreenState extends State<Math10Screen> {
  TextStyle heading3 = TextStyle(fontSize: 25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Toán',
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              QuesionMathModel(topic: math1)));
                }),
          ],
        ),
      ),
    );
  }
}
