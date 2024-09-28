import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
class AchievementChartScreen extends StatefulWidget {
  const AchievementChartScreen({Key? key}) : super(key: key);
  @override
  State<AchievementChartScreen> createState() => _AchievementChartScreenState();
}
class _AchievementChartScreenState extends State<AchievementChartScreen> {
  List<List<dynamic>> ListData = [[]];
  String docIDs = 'nn';
  final Users = FirebaseAuth.instance.currentUser;
  _colorSubject(String subject, Color _color) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 30,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(45),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '${subject}',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
  _Total(dynamic Number) {
    return Row(children:<Widget> [
      SizedBox(
        width: 10,
      ),
    Expanded(
        child: Text(
          'Tỉ lệ bài làm đúng',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
      ),
 
     
     Expanded(
        child: new CircularPercentIndicator(
          radius: 50,
          lineWidth: 15,
          animation: true,
          percent: 0.7,
          center: new Text(
            "${Number} %",
            style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
          ),
          footer: new Text(
            "Mục tiêu : 100%\nHoàn thành: ${Number} %",
            style: new TextStyle(fontSize: 17.0),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.green,
        ),
      ),
    ]);
  }

  String _selectedValue = formatDate(DateTime.now(), [M, '-', yyyy]);
  chartToRun(dynamic ListData) {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        startYAxisAtDataMinRequested: true,
      ),
    );

    chartData = ChartData(
      dataRowsColors: [Colors.green, Colors.red],
      dataRows: [
        [
          ListData[0][1],
          ListData[1][1],
          ListData[2][1],
          ListData[3][1],
          ListData[4][1],
          ListData[5][1],
          ListData[6][1],
          ListData[7][1],
          ListData[8][1]
        ],
        [
          ListData[0][2],
          ListData[1][2],
          ListData[2][2],
          ListData[3][2],
          ListData[4][2],
          ListData[5][2],
          ListData[6][2],
          ListData[7][2],
          ListData[8][2]
        ],
      ],
      xUserLabels: const [
        'Toán',
        'Tiếng\nAnh',
        'Ngữ\nVăn',
        'Lịch\nSử',
        'Đại\nLý',
        'Vật\nLý',
        'Hóa\nHọc',
        'Sinh\nHọc',
        'Công\nDân'
      ],
      dataRowsLegends: const [
        'Tỉ lệ đúng',
        'Tỉ lệ sai',
      ],
      chartOptions: chartOptions,
    );
    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );
    var verticalBarChart = VerticalBarChart(
      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }

  _Time(List<double> ListData) {
    return PieChart(PieChartData(
        centerSpaceRadius: 10,
        borderData: FlBorderData(show: false),
        sections: [
          PieChartSectionData(
              value: ListData[0], color: Colors.red, radius: 100),
          PieChartSectionData(
              value: ListData[1],
              color: Color.fromARGB(255, 255, 170, 199),
              radius: 110),
          PieChartSectionData(
              value: ListData[2], color: Colors.grey, radius: 120),
          PieChartSectionData(
              value: ListData[3], color: Colors.green, radius: 100),
          PieChartSectionData(
              value: ListData[4], color: Colors.purple, radius: 110),
          PieChartSectionData(
              value: ListData[5], color: Colors.yellow, radius: 120),
          PieChartSectionData(
              value: ListData[6], color: Colors.orange, radius: 100),
          PieChartSectionData(
              value: ListData[7], color: Colors.amber, radius: 110),
          PieChartSectionData(
              value: ListData[8], color: Colors.blue, radius: 120),
        ]));
  }

  _DoneQuesion(List<double> ListData) {
    return PieChart(PieChartData(
        centerSpaceRadius: 10,
        borderData: FlBorderData(show: false),
        sections: [
          PieChartSectionData(
              value: ListData[0], color: Colors.red, radius: 100),
          PieChartSectionData(
              value: ListData[1],
              color: Color.fromARGB(255, 255, 170, 199),
              radius: 110),
          PieChartSectionData(
              value: ListData[2], color: Colors.grey, radius: 120),
          PieChartSectionData(
              value: ListData[3], color: Colors.green, radius: 100),
          PieChartSectionData(
              value: ListData[4], color: Colors.purple, radius: 110),
          PieChartSectionData(
              value: ListData[5], color: Colors.yellow, radius: 120),
          PieChartSectionData(
              value: ListData[6], color: Colors.orange, radius: 100),
          PieChartSectionData(
              value: ListData[7], color: Colors.amber, radius: 110),
          PieChartSectionData(
              value: ListData[8], color: Colors.blue, radius: 120),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              setState(() {
                docIDs = document.reference.id;
              });
            }));
    List<String> subject = [
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
    for (int i = 0; i < subject.length; i++) {
      ListData.add([subject[i]]);
      for (int k = 0; k < 3; k++) {
        ListData[i].add(0.0);
      }
    }
    TextStyle styleTitle = TextStyle(fontSize: 25, fontWeight: FontWeight.w800);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(
          'Bảng thành tích',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
      ),
      body: ListView(
        children: [
          Text('Thông kê', style: styleTitle),
          Container(
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(255, 189, 189, 1),
              onPressed: () {
                showMonthPicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2030),
                ).then((date) {
                  if (date != null) {
                    setState(() {
                      _selectedValue = formatDate(date, [M, '-', yyyy]);
                    });
                  }
                });
              },
              child: Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Thời gian thông kê : ${_selectedValue}',
            style: TextStyle(fontFamily: AutofillHints.location, fontSize: 20),
          ),
          Text(
            'Số phút luyện tập',
            style: styleTitle,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(docIDs)
                  .collection('Achievement_Board')
                  .doc(_selectedValue)
                  .collection(_selectedValue)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  List idSubject = [];
                  List idSnap = [];
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        for (int i = 0; i < 9; i++) {
                          ListData[i][0] = 0.0;
                          ListData[i][1] = 0.0;
                          ListData[i][2] = 0.0;
                        }
                        for (int i = 0; i < 9; i++) {
                          for (int k = 0; k < snap.length; k++) {
                            if (subject[i] == snap[k].id) {
                              idSubject.add(i);
                              idSnap.add(k);
                            }
                          }
                        }
                        for (int i = 0; i < snap.length; i++) {
                          double Time = snap[idSnap[i]]
                                  ['total_practice_hours'] *
                              100 /
                              100;
                          ListData[idSubject[i]][0] = snap[idSnap[i]]
                                  ['total_practice_hours'] *
                              100 /
                              100;
                        }
                        List<double> ListTime = [
                          ListData[0][0],
                          ListData[1][0],
                          ListData[2][0],
                          ListData[3][0],
                          ListData[4][0],
                          ListData[5][0],
                          ListData[6][0],
                          ListData[7][0],
                          ListData[8][0]
                        ];
                        return Container(height: 250, child: _Time(ListTime));
                      });
                } else {
                  List<double> ListTime = [
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0
                  ];
                  return Container(height: 250, child: _Time(ListTime));
                }
              }),
          Text(
            'Số câu đã làm',
            style: styleTitle,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(docIDs)
                  .collection('Achievement_Board')
                  .doc(_selectedValue)
                  .collection(_selectedValue)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  List idSubject = [];
                  List idSnap = [];
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        dynamic True = 0;
                        dynamic Total = 0;
                        List<double> ListQ = [
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0,
                          0.0
                        ];
                        for (int i = 0; i < 9; i++) {
                          for (int k = 0; k < snap.length; k++) {
                            if (subject[i] == snap[k].id) {
                              idSubject.add(i);
                              idSnap.add(k);
                            }
                          }
                        }
                        for (int i = 0; i < 9; i++) {
                          ListData[i][0] = 0.0;
                          ListData[i][1] = 0.0;
                          ListData[i][2] = 0.0;
                        }
                        for (int i = 0; i < snap.length; i++) {
                          ListQ[idSubject[i]] += snap[idSnap[i]]
                                  ['number_true_answer'] +
                              snap[idSnap[i]]['number_false_answer'];
                        }

                        return Container(
                            height: 250, child: _DoneQuesion(ListQ));
                      });
                } else {
                  List<double> ListQ = [
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0
                  ];
                  return Container(height: 250, child: _DoneQuesion(ListQ));
                }
              }),
          Container(
            child: Column(
              children: [
                _colorSubject('Toán', Colors.red),
                _colorSubject('Tiếng Anh', Color.fromARGB(255, 255, 170, 199)),
                _colorSubject('Ngữ Văn', Colors.grey),
                _colorSubject('Lịch Sử', Colors.green),
                _colorSubject('Đại Lý', Colors.purple),
                _colorSubject('Vật Lý', Colors.yellow),
                _colorSubject('Hóa Học', Colors.orange),
                _colorSubject('Sinh Học', Colors.amber),
                _colorSubject('Công dân', Colors.blue),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(docIDs)
                  .collection('Achievement_Board')
                  .doc(_selectedValue)
                  .collection(_selectedValue)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  List idSubject = [];
                  List idSnap = [];
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        dynamic True = 0;
                        dynamic Total = 0;
                        for (int i = 0; i < 9; i++) {
                          ListData[i][0] = 0.0;
                          ListData[i][1] = 0.0;
                          ListData[i][2] = 0.0;
                        }
                        for (int i = 0; i < snap.length; i++) {
                          True += snap[i]['number_true_answer'];
                          Total += snap[i]['number_true_answer'] +
                              snap[i]['number_false_answer'];
                        }
                        dynamic result = True * 100 / Total;
                        return Container(
                            height: 300,
                            child: _Total(result.toStringAsFixed(1)));
                      });
                } else {
                  return Container(height: 300, child: _Total(0));
                }
              }),
          SizedBox(
            height: 10,
          ),
          Text('Biểu đồ tỉ lệ đúng các môn', style: styleTitle),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(docIDs)
                  .collection('Achievement_Board')
                  .doc(_selectedValue)
                  .collection(_selectedValue)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  List idSubject = [];
                  List idSnap = [];
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        for (int i = 0; i < 9; i++) {
                          ListData[i][1] = 0.0;
                          ListData[i][2] = 0.0;
                          ListData[i][3] = 0.0;
                        }
                        for (int i = 0; i < 9; i++) {
                          for (int k = 0; k < snap.length; k++) {
                            if (subject[i] == snap[k].id) {
                              idSubject.add(i);
                              idSnap.add(k);
                            }
                          }
                        }
                        for (int i = 0; i < snap.length; i++) {
                          double number_true_answer = 100 *
                              snap[idSnap[i]]['number_true_answer'] /
                              (snap[idSnap[i]]['number_true_answer'] +
                                  snap[idSnap[i]]['number_false_answer']);
                          double number_false_answer = 100 *
                              snap[idSnap[i]]['number_false_answer'] /
                              (snap[idSnap[i]]['number_true_answer'] +
                                  snap[idSnap[i]]['number_false_answer']);

                          ListData[idSubject[i]][1] = number_true_answer;
                          ListData[idSubject[i]][2] = number_false_answer;
                        }

                        return Container(
                          height: 500,
                          child: chartToRun(ListData),
                        );
                      });
                } else {
                  return Container(
                    height: 500,
                    child: chartToRun(ListData),
                  );
                }
              }),
        ],
      ),
    );
  }
}

Future<User?> readUser(String time, String subject) async {
  dynamic docIDs;
  final Users = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: '${Users?.email}')
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs = document.reference.id;
          }));
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(docIDs)
      .collection('Achievement_Board')
      .doc(time)
      .collection(subject)
      .doc(subject);
  final snapshot = await docUser.get();
  return User.fromJson(snapshot.data()!);
}

class User {
  dynamic total_practice_hours;
  dynamic number_true_answer;
  dynamic number_false_answer;
  User({
    required this.total_practice_hours,
    required this.number_true_answer,
    required this.number_false_answer,
  });
  static User fromJson(Map<String, dynamic> json) => User(
        total_practice_hours: json['total_practice_hours'],
        number_true_answer: json['number_true_answer'],
        number_false_answer: json['number_false_answer'],
      );
}
