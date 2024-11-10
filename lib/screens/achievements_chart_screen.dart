import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AchievementChartScreen extends StatefulWidget {
  const AchievementChartScreen({Key? key}) : super(key: key);

  @override
  State<AchievementChartScreen> createState() => _AchievementChartScreenState();
}

class _AchievementChartScreenState extends State<AchievementChartScreen> {
  String docID = 'nn';
  final currentUser = FirebaseAuth.instance.currentUser;
  String _selectedValue = formatDate(DateTime.now(), [M, '-', yyyy]);

  @override
  void initState() {
    super.initState();
    _fetchUserDocument();
  }

  // Function to fetch the document ID of the current user
  void _fetchUserDocument() async {
    final userEmail = currentUser?.email;
    if (userEmail != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          docID = snapshot.docs.first.id;
        });
      }
    }
  }

  // Widget for displaying the overall completion percentage
  Widget _Total(double percentage) {
    return Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'Tỉ lệ bài làm đúng',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          child: CircularPercentIndicator(
            radius: 50,
            lineWidth: 15,
            animation: true,
            percent: percentage / 100,
            center: Text(
              "${percentage.toStringAsFixed(1)} %",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
            ),
            footer: Text(
              "Mục tiêu : 100%\nHoàn thành: ${percentage.toStringAsFixed(1)} %",
              style: TextStyle(fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.green,
          ),
        ),
      ],
    );
  }

  // Widget for displaying pie chart based on question completion data
  Widget _DoneQuesion(List<double> listData) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 10,
        borderData: FlBorderData(show: false),
        sections: List.generate(listData.length, (index) {
          return PieChartSectionData(
            value: listData[index],
            color: _getColorForSection(index),
            radius: 100 + (index * 10),
          );
        }),
      ),
    );
  }

  // Helper function to return color based on section index
  Color _getColorForSection(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Color.fromARGB(255, 255, 170, 199);
      case 2:
        return Colors.grey;
      case 3:
        return Colors.green;
      case 4:
        return Colors.purple;
      case 5:
        return Colors.yellow;
      case 6:
        return Colors.orange;
      case 7:
        return Colors.amber;
      case 8:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> subject = [
      'Toán', 'Tiếng Anh', 'Ngữ Văn', 'Lịch Sử', 'Đại Lý',
      'Vật Lý', 'Hóa Học', 'Sinh Học', 'Công Dân'
    ];
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Thông kê', style: styleTitle),
          ),
          FloatingActionButton(
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
            child: Icon(Icons.calendar_today, color: Colors.black),
          ),
          SizedBox(height: 10),
          Text('Thời gian thông kê : $_selectedValue', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          
          // Display pie chart for completed questions
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Số câu đã làm', style: styleTitle),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(docID)
                .collection('Achievement_Board')
                .doc(_selectedValue)
                .collection(_selectedValue)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.docs;
                List<double> questionCompletion = List.generate(9, (index) => 0.0);
                for (var doc in snap) {
                  for (int i = 0; i < subject.length; i++) {
                    if (doc.id == subject[i]) {
                      questionCompletion[i] += doc['number_true_answer'] + doc['number_false_answer'];
                    }
                  }
                }
                return Container(
                  height: 250,
                  child: _DoneQuesion(questionCompletion),
                );
              } else {
                return Container(
                  height: 250,
                  child: _DoneQuesion(List.generate(9, (index) => 0.0)),
                );
              }
            },
          ),
          
          // Display the overall percentage of correct answers
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Tỉ lệ hoàn thành', style: styleTitle),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(docID)
                .collection('Achievement_Board')
                .doc(_selectedValue)
                .collection(_selectedValue)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.docs;
                double trueAnswers = 0;
                double totalAnswers = 0;
                for (var doc in snap) {
                  trueAnswers += doc['number_true_answer'];
                  totalAnswers += doc['number_true_answer'] + doc['number_false_answer'];
                }
                double completionPercentage = totalAnswers == 0 ? 0 : (trueAnswers / totalAnswers) * 100;
                return Container(
                  height: 300,
                  child: _Total(completionPercentage),
                );
              } else {
                return Container(
                  height: 300,
                  child: _Total(0),
                );
              }
            },
          ),
        ],
      ),
    );
  }
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
