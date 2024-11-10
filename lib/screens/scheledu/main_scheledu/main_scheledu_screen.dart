import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:travo_app_source/models/task.dart';
import 'package:travo_app_source/screens/scheledu/add_task/add_task_screen.dart';
import 'package:travo_app_source/screens/scheledu/main_scheledu/main_secheledu_body.dart';

class MainScheleduScreen extends StatefulWidget {
  const MainScheleduScreen({Key? key}) : super(key: key);
  @override
  State<MainScheleduScreen> createState() => _MainScheleduScreenState();
}



class _MainScheleduScreenState extends State<MainScheleduScreen> {
  dynamic currentTime = formatDate(DateTime.now(), [M, '-', d, '-', yyyy]);
  String _selectedValue = formatDate(DateTime.now(), [M, '-', d, '-', yyyy]);
  DatePickerController _controller = DatePickerController();
  List<String> docIDs2 = [];
  String docIDs = 'nn';
  @override
  void instance() async {
    // readUser();
    super.initState();
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
  final Users = FirebaseAuth.instance.currentUser;
  Future<TaskScheledu?> readUser() async {
    dynamic docIDs;
    return docIDs;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Thiết Lập Lịch Trình',
            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          ),
          backgroundColor: Color.fromRGBO(255, 189, 189, 1),
          foregroundColor: Colors.black,
        ),
        body: MainSecheleduBody(),);
  }
}
