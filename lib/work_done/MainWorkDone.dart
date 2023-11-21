import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travo_app_source/work_done/DetailTest.dart';

class MainWorkDoneScreen extends StatefulWidget {
  const MainWorkDoneScreen({Key? key, required this.docIDs}) : super(key: key);
  final String docIDs;
  @override
  State<MainWorkDoneScreen> createState() => _MainWorkDoneScreenState();
}

class _MainWorkDoneScreenState extends State<MainWorkDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
        title: Text(
          'Danh sách đề thi đã làm',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: Colors.black,
      ),
      body: ListView(children: <Widget>[
        Table(
          children: [
            TableRow(children: [
              Text(
                "Ngày làm",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 18),
              ),
              Text("Môn học",
                  textScaleFactor: 1, style: TextStyle(fontSize: 18)),
              Text("Kết quả",
                  textScaleFactor: 1, style: TextStyle(fontSize: 18)),
              Text("Thời gian còn lại ",
                  textScaleFactor: 1, style: TextStyle(fontSize: 18)),
              Text("", textScaleFactor: 1),
            ]),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.docIDs)
                  .collection('Test_Done')
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
                        return Table(
                          children: [
                            TableRow(children: [
                              Text(
                                "${snap[index]['TimeDay']}",
                                textScaleFactor: 1,
                              ),
                              Text("${snap[index]['Subject']}",
                                  textScaleFactor: 1),
                              Text(
                                  "${snap[index]['TrueAnswer']}/${snap[index]['NumberAnswer']}",
                                  textScaleFactor: 1),
                              Text(
                                  "${snap[index]['Time']}/${snap[index]['TotalTime']}",
                                  textScaleFactor: 1),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailTestScreen(
                                                    TrueAnswer: snap[index]
                                                        ['TrueAnswer'],
                                                    NumberAnswer: snap[index]
                                                        ['NumberAnswer'],
                                                    Time: snap[index]['Time'],
                                                    TotalTime: snap[index]
                                                        ['TotalTime'],
                                                    falseAnwer: snap[index]
                                                        ['FalseAnwer'],
                                                    ListQuestion: snap[index]
                                                        ['ListQuestion'],
                                                    ListTrueAnswer: snap[index]
                                                        ['ListTrueAnswer'],
                                                    Choose: snap[index]
                                                        ['listAnswer'])));
                                  },
                                  child: Text(
                                    'Xem chi tiết',
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ]),
                          ],
                        );
                      });
                } else {
                  return SizedBox(
                    height: 0,
                  );
                }
              }),
        ),
      ]),
    );
  }
}
