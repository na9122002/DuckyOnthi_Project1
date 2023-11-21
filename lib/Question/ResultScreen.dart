import 'package:flutter/material.dart';
import 'package:travo_app_source/Question/Question_model_normal.dart';
import 'package:travo_app_source/Question/review_question.dart';
import 'package:travo_app_source/representation/BottomNavigationBar.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {Key? key,
      required this.mark,
      required this.chooseF,
      required this.M,
      required this.S,
      required this.topic,
      required this.quantityQ,
      required this.listAnwer,
      required this.Choose,
      required this.subject,
      required this.time})
      : super(key: key);
  static const routeName = "ResultScreen";
  final int mark;
  final int chooseF;
  final String topic;
  final int M;
  final int S;
  final int quantityQ;
  final dynamic listAnwer;
  final dynamic Choose;
  final String subject;
  final int time;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: ListView(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: 80,
              ),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    margin: EdgeInsets.only(right: 10, left: 14, top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(90),
                      border: Border(
                        top: BorderSide(width: 3, color: Colors.red),
                        left: BorderSide(width: 3, color: Colors.red),
                        right: BorderSide(width: 3, color: Colors.red),
                        bottom: BorderSide(width: 3, color: Colors.red),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.mark * 10 / widget.quantityQ}',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 60,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('ĐIỂM',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Tổng số câu :${widget.quantityQ}',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Số câu làm đúng :${widget.mark}',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Thời gian làm bài :${widget.time - widget.M}:${60 - widget.S}',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    QuesionNormalModel(
                                      topic: widget.topic,
                                      subject: widget.subject,
                                    )),
                          );
                        },
                        child: Container(
                          height: 65,
                          width: width / 3.583,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 189, 189, 1),
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Làm lại',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Container(
                          height: 65,
                          width: width / 3.583,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 189, 189, 1),
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Trang chủ',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewQuestionScreen(
                                        topic: widget.topic,
                                        listAnwer: widget.listAnwer,
                                        Choose: widget.Choose,
                                      )));
                        },
                        child: Container(
                          height: 65,
                          width: width / 3.583,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 189, 189, 1),
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Xem lại',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
