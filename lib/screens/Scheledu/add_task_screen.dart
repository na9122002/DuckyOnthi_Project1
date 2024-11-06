import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travo_app_source/screens/scheledu/main_scheledu_screen.dart';

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
    void showAlertDialog(String Time) {
      DateTime TimeChoose = DateTime.now();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color.fromRGBO(255, 189, 189, 1),
              actions: [
                TimePickerSpinner(
                  is24HourMode: false,
                  normalTextStyle: TextStyle(fontSize: 24, color: Colors.white),
                  highlightedTextStyle:
                      TextStyle(fontSize: 24, color: Colors.black),
                  spacing: 50,
                  itemHeight: 80,
                  //isForce2Digits: true,
                  onTimeChange: (time) {
                    setState(() {
                      TimeChoose = time;
                    });
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Hủy',
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      setState(() {
                        if (Time == 'Start') {
                          startTime.text =
                              formatDate(TimeChoose, [hh, ':', mm, ' ', am]);
                        } else if (Time == 'End') {
                          endTime.text =
                              formatDate(TimeChoose, [hh, ':', mm, ' ', am]);
                        }
                      });

                      Navigator.pop(context);
                    },
                    child: const Text('Hoàn Thành',
                        style: TextStyle(color: Colors.white))),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
        title: Text(
          'Thêm Nhiệm  Vụ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<User?>(builder: (context, snapshot) {
        return ListView(
          children: [
            Text(
              'Add Task ${widget.date}',
              style: TextStyle(fontSize: 25),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 15),
              Text(
                'Tiêu Đề',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 100,
                controller: title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nhập Tiêu Đề',
                  fillColor: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Ghi chú',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 150,
                controller: note,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nhập Ghi Chú',
                  fillColor: Colors.black,
                ),
              ),
              SizedBox(height: 15),
            ]),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: startTime,
                    decoration: InputDecoration(
                      hintText: "${StratTime}",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      suffixIcon: Container(
                        margin: EdgeInsets.all(8),
                        child: IconButton(
                          color: Color.fromRGBO(255, 189, 189, 1),
                          iconSize: 40,
                          icon: const Icon(Icons.access_alarm_rounded),
                          onPressed: () {
                            showAlertDialog('Start');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: endTime,
                    decoration: InputDecoration(
                      hintText: "${EndTime}",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      suffixIcon: Container(
                        margin: EdgeInsets.all(8),
                        child: IconButton(
                          color: Color.fromRGBO(255, 189, 189, 1),
                          iconSize: 40,
                          icon: const Icon(Icons.access_alarm_rounded),
                          onPressed: () {
                            showAlertDialog('End');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'Lời Nhắc Nhở',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLength: 100,
              controller: remind,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập Lời Nhắc Nhở',
                fillColor: Colors.black,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 189, 189, 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        if (title.text == '' ||
                            note.text == '' ||
                            startTime.text == '' ||
                            endTime.text == '' ||
                            remind.text == '') {
                          Fluttertoast.showToast(
                            msg: 'Vui Lòng Kiểm Tra Lại Thông Tin',
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 3, 2, 2),
                          );
                        } else {
                          createTask(snapshot);
                          Fluttertoast.showToast(
                            msg: 'Thêm nhiệm vụ thành công',
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 3, 2, 2),
                          );
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScheleduScreen()));
                        }
                      },
                      child: Text('Tạo Nhiệm Vụ',
                          style:
                              TextStyle(color: Colors.black, fontSize: 20)))),
            )
          ],
        );
      }),
    );
  }

  Future createTask(dynamic snapshot) async {
    dynamic docIDs;
    final user = snapshot.data;
    final Users = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              docIDs = document.reference.id;
            }));
    final _user = User(
      title: title.text,
      Time: widget.date,
      note: note.text,
      remind: remind.text,
      startTime: startTime.text,
      endTime: endTime.text,
    );
    final json = _user.toJson();
    final docUser = FirebaseFirestore.instance.collection('users').doc(docIDs);

    docUser
        .collection('Schedule')
        .doc('${widget.date}')
        .collection('${widget.date}')
        .doc()
        .set(json);
  }
}

class User {
  final String title;
  final String note;
  final String startTime;
  final String endTime;
  final String remind;
  final String Time;

  User({
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.Time,
  });
  Map<String, dynamic> toJson() => {
        'title': title,
        'note': note,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'Time': Time,
      };

  static User fromJson(Map<String, dynamic> json) => User(
      title: json['title'],
      note: json['note'],
      Time: json['time'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      remind: json['remind']);
}
