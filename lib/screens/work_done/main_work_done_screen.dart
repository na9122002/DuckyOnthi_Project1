import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travo_app_source/screens/work_done/detail_test_screen.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.docIDs)
            .collection('Test_Done')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No tests done yet'));
          }

          final snap = snapshot.data!.docs;

          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            "${snap[index]['TimeDay']}",
                            textScaleFactor: 1,
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            "${snap[index]['Subject']}",
                            textScaleFactor: 1,
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            "${snap[index]['TrueAnswer']}/${snap[index]['NumberAnswer']}",
                            textScaleFactor: 1,
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            "${snap[index]['Time']}/${snap[index]['TotalTime']}",
                            textScaleFactor: 1,
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailTestScreen(
                                    TrueAnswer: snap[index]['TrueAnswer'],
                                    NumberAnswer: snap[index]['NumberAnswer'],
                                    Time: snap[index]['Time'],
                                    TotalTime: snap[index]['TotalTime'],
                                    falseAnwer: snap[index]['FalseAnwer'],
                                    ListQuestion: snap[index]['ListQuestion'],
                                    ListTrueAnswer: snap[index]
                                        ['ListTrueAnswer'],
                                    Choose: snap[index]['listAnswer'],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Xem chi tiết',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
