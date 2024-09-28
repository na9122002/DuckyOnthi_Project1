import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_app_source/network/blocs/question_bloc.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/network/models_api/item_api_model.dart';
import 'package:travo_app_source/screens/do_and_review_questions/ResultScreen.dart';
class QuesionNormalApiModel extends StatefulWidget {
  const QuesionNormalApiModel(
      {Key? key, required this.listItem})
      : super(key: key);
  final List<ItemModel>  listItem;
 
  @override
  State<QuesionNormalApiModel> createState() => _QuesionNormalApiModelState();
}
  
  
class _QuesionNormalApiModelState extends State<QuesionNormalApiModel> {
  final bloc = QuestionBloc();
  final PageController pageController = PageController();
  final StreamController<int> streamController = StreamController<int>();
  String MonthTime = formatDate(DateTime.now(), [M, '-', yyyy]);
  
  @override
  void initState() {

    super.initState();
  }

  List<List<Color?>> _color = [[]];
  int quantityQ = 0;
  int time = 0;
  int Minutes = 0;
  int Seconds = 0;
  List<String?> Choose = [];
  int mark = 0;
  int chooseF = 0;
  List<List<String?>> listAnwer = [[]];
  
  _CreatListR(int i,List<ItemModel> _models) {
    List<int> number = [
      0,
      1,
      2,
      3,
    ];
    List<String?> listR = ['', '', '', ''];
 final bloc = QuestionBloc();
    bloc.fetchAllQuestion();
    // List<String?> list=[];
    List<String?> list = [
      _models[i].trueAnwer,
      _models[i].falseAnwer1,
      _models[i].falseAnwer2,
      _models[i].falseAnwer3,
    ];
    for (int j = 0; j < 4; j++) {
      int index = Random().nextInt(number.length);
      int randIndex = number[index];
      number.remove(randIndex);
      listR[j] = list[randIndex];
    }
    return listR;
  }

  _CreatNopBai(int quantityQ, dynamic snapshot, dynamic OldHour, dynamic time,dynamic _models) {
    for (int i = 0; i < _models.length; i++) {
      if (Choose[i] == _models[i].trueAnwer && _models[i].id != '-') {
        mark++;
      }
      if (Choose[i] != _models[i].trueAnwer &&
          Choose[i] != "" &&
          _models[i].id != '-') {
        chooseF++;
      }
    }
    String timeWorkDone = '${Minutes} : ${Seconds}';
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(
                  mark: mark,
                  chooseF: chooseF,
                  M: Minutes,
                  S: Seconds,
                  topic: 'topic2',
                  quantityQ: quantityQ,
                  listAnwer: listAnwer,
                  Choose: Choose,
                  subject: 'Tiếng Anh',
                  time: time,
                )));
  }

  _NumberQuesion(int start, int finish) {
    return Row(
      children: [
        for (int i = start; i < finish; i++)
          Container(
            height: 30,
            width: 40,
            child: TextButton(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 189, 189, 1),
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {
                  pageController.jumpToPage(i);
                }),
          ),
      ],
    );
  }

  createWorkDone(
      dynamic snapshot,
      String subject,
      String Time,
      int FalseAnwer,
      dynamic listAnswer,
      String Topic,
      int TrueAnswer,
      int NumberAnswer,
      dynamic ListQuestion,
      dynamic ListTrueAnswer) async {
    dynamic docIDUser;
    final Users = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDUser = document.reference.id;
            }));
    final _user = UserWorkDone(
      TimeDay: formatDate(DateTime.now(), [dd, '-', M, '-', yyyy]),
      Subject: subject,
      Time: Time,
      TotalTime: time,
      FalseAnwer: FalseAnwer,
      TrueAnswer: TrueAnswer,
      NumberAnswer: NumberAnswer,
      listAnswer: Choose,
      ListQuestion: ListQuestion,
      ListTrueAnswer: ListTrueAnswer,
      TimeID: formatDate(DateTime.now(),
          [dd, '-', '-', M, '-', yyyy, '-', HH, '-', mm, '-', ss]),
    );
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(docIDUser)
        .collection('Test_Done')
        .doc();
    final json = _user.toJson();
    await docUser.set(json);
  }

  _CreatExercisesDone(dynamic OldHour, dynamic numbertrueAnswer,
      dynamic numberflaseAnwer, dynamic _time, dynamic _minutes,dynamic _models) async {
    int trueAnswerNow = 0;
    int falseAnwerNow = 0;
    for (int i = 0; i < _models!.length; i++) {
      if (Choose[i] == _models![i].trueAnswer && _models![i].id != '-') {
        trueAnswerNow++;
      }
      if (Choose[i] != _models![i].trueAnswer &&
          Choose[i] != "" &&
          _models![i].id != '-') {
        falseAnwerNow++;
      }
    }
    dynamic docIDUser;
    OldHour += _time - _minutes;
    numberflaseAnwer = falseAnwerNow + numberflaseAnwer;
    numbertrueAnswer = trueAnswerNow + numbertrueAnswer;
    final Users = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDUser = document.reference.id;
            }));
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(docIDUser)
        .collection('Achievement_Board')
        .doc(MonthTime)
        .collection(MonthTime)
        .doc('Tiếng Anh');
    final user = User(
        total_practice_hours: OldHour,
        number_true_answer: numbertrueAnswer,
        number_false_answer: numberflaseAnwer);
    final json = user.toJson();
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    List<ItemModel> _models=widget.listItem;
    if (_models.length < 25) {
      time = 15;
      quantityQ = 20;
    } else if (_models.length > 45) {
      time = 60;
      quantityQ = 50;
    } else if (_models.length < 45 && _models.length > 30) {
      time = 50;
      quantityQ = 40;
    }
    for (int i = 0; i < _models.length; i++) {
      Choose.add('');
    }
    for (int i = 0; i < _models.length; i++) {
      dynamic listR = _CreatListR(i,widget.listItem);
      listAnwer.add([]);
      for (int k = 0; k < 4; k++) {
        listAnwer[i].add(listR[k]);
      }
    }
    TextStyle StyleAwnser = TextStyle(color: Colors.black, fontSize: 20);
    for (int i = 0; i < _models.length; i++) {
      _color.add([]);
      for (int k = 0; k < 4; k++) {
        _color[i].add(Colors.white);
      }
    }
    dynamic docIDs;
    final Users = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs = document.reference.id;
            }));
    dynamic OldHour = 0;
    dynamic trueAnswer = 0;
    dynamic falseAnwer = 0;
    List<String?> ListQuestion = [];
    List<String?> ListTrueAnswer = [];
    for (int i = 0; i < _models.length; i++) {
      if (_models[i].falseAnwer1 != '-') {
        ListQuestion.add(_models[i].question);
        ListTrueAnswer.add(_models[i].trueAnwer);
      }
    }
    return FutureBuilder<User?>(
        future: readDATA(MonthTime, 'Tiếng Anh'),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user?.total_practice_hours != null) {
            OldHour = user?.total_practice_hours;
            trueAnswer = user?.number_true_answer;
            falseAnwer = user?.number_false_answer;
          } else {
            OldHour = 0;
            trueAnswer = 0;
            falseAnwer = 0;
          }
          var size, height, width;
          size = MediaQuery.of(context).size;
          height = size.height;
          width = size.width;
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              title: const Text('Đề Thi',
                  style: TextStyle(fontSize: 30, color: Colors.black)),
              backgroundColor: Color.fromRGBO(255, 189, 189, 1),
              actions: [
                TextButton(
                  child: Text(
                    'Nộp bài',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  onPressed: () {
                    String timeWorkDone = '${Minutes} : ${Seconds}';
                    dynamic CWD;

                    _CreatNopBai(quantityQ, snapshot, OldHour, time,_models);
                    _CreatExercisesDone(
                        OldHour, trueAnswer, falseAnwer, time, Minutes,_models);
                    // StreamBuilder(
                    //     stream: FirebaseAuth.instance.authStateChanges(),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData) {
                    //         CWD = createWorkDone(
                    //             snapshot,
                    //             'Tiếng Anh',
                    //             timeWorkDone,
                    //             chooseF,
                    //             listAnwer,
                    //             'topic2',
                    //             mark,
                    //             quantityQ,
                    //             ListQuestion,
                    //             ListTrueAnswer);
                    //       }
                    //       return CWD;
                    //     });
                  },
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: height / 10.1,
              color: Colors.black,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: width / 5.1),
                            child: Image.asset(AssetHelper.imagemuiten),
                            height: 60,
                            width: 60,
                          ),
                          onTap: () {
                            pageController.previousPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          }),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: TweenAnimationBuilder<Duration>(
                              duration: Duration(minutes: time),
                              tween: Tween(
                                  begin: Duration(minutes: time),
                                  end: Duration.zero),
                              onEnd: () {
                                String timeWorkDone = '${Minutes} : ${Seconds}';
                                _CreatNopBai(
                                    quantityQ, snapshot, OldHour, time,_models);
                                _CreatExercisesDone(OldHour, trueAnswer,
                                    falseAnwer, time, Minutes,_models);
                                createWorkDone(
                                    snapshot,
                                    'Tiếng Anh',
                                    timeWorkDone,
                                    chooseF,
                                    listAnwer,
                                    'topic2',
                                    mark,
                                    quantityQ,
                                    ListQuestion,
                                    ListTrueAnswer);
                              },
                              builder: (BuildContext context, Duration value,
                                  Widget? child) {
                                final minutes = value.inMinutes;
                                final seconds = value.inSeconds % 60;
                                Minutes = minutes;
                                Seconds = seconds;
                                return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text('$minutes:$seconds',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30)));
                              }),
                        ),
                      ),
                      InkWell(
                          child: Container(
                            margin: EdgeInsets.only(right: width / 5.1),
                            child: Image.asset(AssetHelper.imagemuiten2),
                            height: 60,
                            width: 60,
                          ),
                          onTap: () {
                            pageController.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          }),
                    ],
                  ),
                ],
              ),
            ),
            body: ListView(
              children: [
                Container(
                  height: 3000,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: _models.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: GestureDetector(
                              child:
                                  NotificationListener<UserScrollNotification>(
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 10, right: 10),
                                          child: Container(
                                            margin: EdgeInsets.all(15),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Text(
                                                    "Câu ${index+1}: \n ${_models[index].question}",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    color: Color.fromRGBO(
                                                        255, 189, 189, 1),
                                                  ),
                                                  child: RadioListTile(
                                                    activeColor: Colors.black,
                                                    groupValue: Choose[index],
                                                    value:
                                                        '${listAnwer[index][0]}',
                                                    title: Text(
                                                      '${listAnwer[index][0]}',
                                                      style: StyleAwnser,
                                                    ),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        Choose[index] = value;

                                                        _color[index][0] =
                                                            Color.fromRGBO(255,
                                                                189, 189, 1);
                                                        _color[index][1] =
                                                            Colors.white;
                                                        _color[index][2] =
                                                            Colors.white;
                                                        _color[index][3] =
                                                            Colors.white;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        255, 189, 189, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                  ),
                                                  child: RadioListTile(
                                                    activeColor: Colors.black,
                                                    groupValue: Choose[index],
                                                    value:
                                                        '${listAnwer[index][1]}',
                                                    title: Text(
                                                      '${listAnwer[index][1]}',
                                                      style: StyleAwnser,
                                                    ),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        Choose[index] = value;
                                                        _color[index][0] =
                                                            Colors.white;
                                                        _color[index][1] =
                                                            Color.fromRGBO(255,
                                                                189, 189, 1);
                                                        _color[index][2] =
                                                            Colors.white;
                                                        _color[index][3] =
                                                            Colors.white;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        255, 189, 189, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                  ),
                                                  child: RadioListTile(
                                                    activeColor: Colors.black,
                                                    groupValue: Choose[index],
                                                    value:
                                                        '${listAnwer[index][2]}',
                                                    title: Text(
                                                      '${listAnwer[index][2]}',
                                                      style: StyleAwnser,
                                                    ),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        Choose[index] = value;
                                                        _color[index][0] =
                                                            Colors.white;
                                                        _color[index][1] =
                                                            Colors.white;
                                                        _color[index][2] =
                                                            Color.fromRGBO(255,
                                                                189, 189, 1);
                                                        _color[index][3] =
                                                            Colors.white;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        255, 189, 189, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                  ),
                                                  child: RadioListTile(
                                                    activeColor: Colors.black,
                                                    groupValue: Choose[index],
                                                    value:
                                                        '${listAnwer[index][3]}',
                                                    title: Text(
                                                      '${listAnwer[index][3]}',
                                                      style: StyleAwnser,
                                                    ),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        Choose[index] = value;
                                                        _color[index][0] =
                                                            Colors.white;
                                                        _color[index][1] =
                                                            Colors.white;
                                                        _color[index][2] =
                                                            Colors.white;
                                                        _color[index][3] =
                                                            Color.fromRGBO(255,
                                                                189, 189, 1);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: SafeArea(
                  child: ListView(
                children: [
                  for (int i = 0; i < _models.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          TextButton(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                pageController.jumpToPage(i);
                              }),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: _color[i][0],
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: TextButton(
                                child: Text(
                                  'A',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Choose[i] = listAnwer[i][0];
                                    _color[i][0] =
                                        Color.fromRGBO(255, 189, 189, 1);
                                    _color[i][1] = Colors.white;
                                    _color[i][2] = Colors.white;
                                    _color[i][3] = Colors.white;
                                  });
                                }),
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: _color[i][1],
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: TextButton(
                                child: Text(
                                  'B',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Choose[i] = listAnwer[i][1];
                                    _color[i][0] = Colors.white;
                                    _color[i][1] =
                                        Color.fromRGBO(255, 189, 189, 1);
                                    _color[i][2] = Colors.white;
                                    _color[i][3] = Colors.white;
                                  });
                                }),
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: _color[i][2],
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: TextButton(
                                child: Text(
                                  'C',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Choose[i] = listAnwer[i][2];
                                    _color[i][0] = Colors.white;
                                    _color[i][1] = Colors.white;
                                    _color[i][2] =
                                        Color.fromRGBO(255, 189, 189, 1);
                                    _color[i][3] = Colors.white;
                                  });
                                }),
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: _color[i][3],
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: TextButton(
                                child: Text(
                                  'D',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Choose[i] = listAnwer[i][3];
                                    _color[i][0] = Colors.white;
                                    _color[i][1] = Colors.white;
                                    _color[i][2] = Colors.white;
                                    _color[i][3] =
                                        Color.fromRGBO(255, 189, 189, 1);
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                ],
              )),
            ),
          );
        });
  }
}

Future<User?> readDATA(String MonthTime, String subject) async {
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
      .doc(MonthTime)
      .collection(MonthTime)
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
  Map<String, dynamic> toJson() => {
        'total_practice_hours': total_practice_hours,
        'number_true_answer': number_true_answer,
        'number_false_answer': number_false_answer,
      };
  static User fromJson(Map<String, dynamic> json) => User(
        total_practice_hours: json['total_practice_hours'],
        number_true_answer: json['number_true_answer'],
        number_false_answer: json['number_false_answer'],
      );
}

class UserWorkDone {
  final String TimeDay;
  final String Subject;
  final String Time;
  final int FalseAnwer;
  final int TrueAnswer;
  final int NumberAnswer;
  final int TotalTime;
  final List<String?> listAnswer;
  final List<String?> ListQuestion;
  final List<String?> ListTrueAnswer;
  final dynamic TimeID;
  UserWorkDone({
    required this.TimeID,
    required this.TotalTime,
    required this.TimeDay,
    required this.Subject,
    required this.Time,
    required this.FalseAnwer,
    required this.TrueAnswer,
    required this.NumberAnswer,
    required this.listAnswer,
    required this.ListQuestion,
    required this.ListTrueAnswer,
  });
  Map<String, dynamic> toJson() => {
        'TimeDay': TimeDay,
        'Subject': Subject,
        'Time': Time,
        'FalseAnwer': FalseAnwer,
        'TrueAnswer': TrueAnswer,
        'NumberAnswer': NumberAnswer,
        'TotalTime': TotalTime,
        'TimeID': TimeID,
        'ListQuestion': ListQuestion,
        'ListTrueAnswer': ListTrueAnswer,
        'listAnswer': listAnswer
      };
  static UserWorkDone fromJson(Map<String, dynamic> json) => UserWorkDone(
      TimeDay: json['TimeDay'],
      Subject: json['Subject'],
      Time: json['Time'],
      FalseAnwer: json['FalseAnwer'],
      TrueAnswer: json['TrueAnswer'],
      NumberAnswer: json['NumberAnswer'],
      listAnswer: json['listAnswer'],
      TotalTime: json['TotalTime'],
      TimeID: json['TimeID'],
      ListQuestion: json['ListQuestion'],
      ListTrueAnswer: json['ListTrueAnswer']);
}
