import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travo_app_source/models/task.dart';
import 'package:travo_app_source/screens/scheledu/add_task/add_task_screen.dart';

class MainSecheleduBody extends StatefulWidget {
  const MainSecheleduBody({Key? key}) : super(key: key);

  @override
  State<MainSecheleduBody> createState() => _MainSecheleduBodyState();
}

class _MainSecheleduBodyState extends State<MainSecheleduBody> {
  @override
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

  _deleteTask(String Date, String IDTask) async {
    dynamic IDUser;
    final Users = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              IDUser = document.reference.id;
            }));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(IDUser)
        .collection('Schedule')
        .doc(Date)
        .collection(Date)
        .doc(IDTask)
        .delete();
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

  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs = document.reference.id;
            }));

    TextStyle styleList = TextStyle(color: Colors.black, fontSize: 20);

    return ListView(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hôm Nay', style: TextStyle(fontSize: 25)),
              Container(
                child: Text(
                  '$currentTime',
                  style: TextStyle(fontStyle: FontStyle.normal, fontSize: 25),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: Color.fromRGBO(255, 189, 189, 1),
            ),
            child: Row(
              children: [
                Icon(Icons.add_circle_sharp),
                TextButton(
                    onPressed: () {
                      //             NotificationService()
                      // .showNotification(title: 'Sample title', body: 'It works!');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddTaskScreen(date: _selectedValue)));
                    },
                    child: Text('Thêm Nhiệm Vụ',
                        style: TextStyle(color: Colors.black))),
              ],
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        padding: EdgeInsets.all(20.0),
        color: Color.fromRGBO(255, 189, 189, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: DatePicker(
                DateTime.now(),
                width: 60,
                height: 80,
                controller: _controller,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    _selectedValue = formatDate(date, [M, '-', d, '-', yyyy]);
                  });
                },
              ),
            ),
            Column(
              children: [
                const Text(
                  "\nDanh Sách Các Nhiệm Vụ\n",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(docIDs)
                      .collection('Schedule')
                      .doc(_selectedValue)
                      .collection(_selectedValue)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Tiêu Đề : ${snap[index]['title']} ',
                                    style: styleList,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Ghi Chú : ${snap[index]['note']}",
                                    style: styleList,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Ngày : ${snap[index]['Time']}",
                                    style: styleList,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Thời Gian Bắt Đầu : ${snap[index]['startTime']}",
                                    style: styleList,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Thời Gian Kết Thúc : ${snap[index]['endTime']}",
                                    style: styleList,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Nhắc Nhở : ${snap[index]['remind']}",
                                    style: styleList,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Color.fromRGBO(
                                                255, 189, 189, 1),
                                            title: Center(
                                                child: Text(
                                                    'Bạn có muốn xóa nhiệm vụ')),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: Text(
                                                    'Có',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    _deleteTask(_selectedValue,
                                                        snap[index].id);
                                                    Navigator.of(context).pop();
                                                  }),
                                              TextButton(
                                                  child: Text('Không',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  })
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 40,
                                      color: Color.fromRGBO(255, 189, 189, 1),
                                    ))
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
