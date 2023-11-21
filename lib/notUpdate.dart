import 'package:flutter/material.dart';

class OthersubjectScreen extends StatefulWidget {
  const OthersubjectScreen({Key? key, required this.subject}) : super(key: key);
  final String subject;
  static const routeName = 'other_subject';
  @override
  State<OthersubjectScreen> createState() => _OthersubjectScreenState();
}

class require {}

class _OthersubjectScreenState extends State<OthersubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Color.fromRGBO(255, 189, 189, 1),
          title: Text('${widget.subject}',
              style: TextStyle(color: Colors.black, fontSize: 25)),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 15),
            child: Text('Đang cập nhật', style: TextStyle(fontSize: 20))));
  }
}
