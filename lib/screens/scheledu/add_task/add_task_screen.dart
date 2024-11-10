import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travo_app_source/screens/scheledu/add_task/add_task_body.dart';
import 'package:travo_app_source/screens/scheledu/main_scheledu/main_scheledu_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key, required this.date}) : super(key: key);

  final dynamic date;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateRangePickerController _datePickerController = DateRangePickerController();
  String StratTime = formatDate(DateTime.now(), [hh, ':', mm, ' ', am]);
  String EndTime = formatDate(DateTime.now(), [hh, ':', mm, ' ', am]);
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController remind = TextEditingController();
  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
        title: Text(
          'Thêm Nhiệm  Vụ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: AddTaskBody(date: widget.date,),
    );
  }

}

