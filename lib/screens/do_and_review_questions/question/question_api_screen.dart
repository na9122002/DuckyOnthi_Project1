import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_app_source/models/user_achievement_board.dart';
import 'package:travo_app_source/network/blocs/question_bloc.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/network/models_api/item_api_model.dart';
import 'package:travo_app_source/screens/do_and_review_questions/result/result_screen.dart';
import 'package:travo_app_source/models/user_work_done_model.dart';
import 'package:travo_app_source/screens/do_and_review_questions/question/question_api_answer.dart';
import 'package:travo_app_source/screens/do_and_review_questions/question/question_api_appbar..dart';
import 'package:travo_app_source/screens/do_and_review_questions/question/question_api_bottom.dart';
import 'package:travo_app_source/screens/do_and_review_questions/question/question_api_drawer.dart';
import 'package:travo_app_source/screens/do_and_review_questions/question/question_controllers.dart';

class QuesionNormalApiModel extends StatefulWidget {
  const QuesionNormalApiModel({Key? key, required this.listItem})
      : super(key: key);
  final List<ItemModel> listItem;

  @override
  State<QuesionNormalApiModel> createState() => creatListR();
}

class creatListR extends State<QuesionNormalApiModel> {
  final bloc = QuestionBloc();
  final PageController pageController = PageController();
  final StreamController<int> streamController = StreamController<int>();
  String MonthTime = formatDate(DateTime.now(), [M, '-', yyyy]);

  @override
  void initState() {
    super.initState();
  }

  DateTime startTime = DateTime.now();
  List<List<Color?>> color = [[]];
  int quantityQ = 0;

  int minutesSpent = 0;

  List<String?> choose = [];
  int mark = 0;
  int chooseF = 0;
  List<List<String?>> listAnswer = [[]];

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    List<ItemModel> _models = widget.listItem;
    quantityQ = _models.length;
    for (int i = 0; i < _models.length; i++) {
      choose.add('');
    }
    for (int i = 0; i < _models.length; i++) {
      dynamic listR = QuestionController.creatListR(i, widget.listItem);
      listAnswer.add([]);
      for (int k = 0; k < 4; k++) {
        listAnswer[i].add(listR[k]);
      }
    }
    TextStyle styleAnswer = TextStyle(color: Colors.black, fontSize: 20);
    for (int i = 0; i < _models.length; i++) {
      color.add([]);
      for (int k = 0; k < 4; k++) {
        color[i].add(Colors.white);
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
    List<String?> listQuestion = [];
    List<String?> listTrueAnswer = [];

    for (int i = 0; i < _models.length; i++) {
      if (_models[i].falseAnwer1 != '-') {
        listQuestion.add(_models[i].question);
        listTrueAnswer.add(_models[i].trueAnwer);
      }
    }
    return FutureBuilder<UserAchievementBoard?>(
        future: QuestionController.readDATA(MonthTime, 'Tiếng Anh'),
        builder: (context, snapshot) {
          final user = snapshot.data;

          return Scaffold(
              appBar: QuestionApiAppbar(
                onPressed: () {
                  DateTime endTime = DateTime.now();
                  Duration difference = endTime.difference(startTime);
                  int seconds = difference.inSeconds;
                  dynamic CWD;

                  QuestionController.creatAchievementBoard(choose,MonthTime,seconds, _models);
                  QuestionController.creatNopBai(quantityQ, snapshot, seconds, _models,choose,mark,chooseF,context,listAnswer,widget.listItem);

                  QuestionController.createWorkDone(
                      snapshot,
                      'Tiếng Anh',
                      seconds.toString(),
                      chooseF,
                      listAnswer,
                      'topic2',
                      mark,
                      quantityQ,
                      listQuestion,
                      listTrueAnswer,choose);
                },
                startTime: startTime,
              ),
              bottomNavigationBar: QuestionApiBottom(
                height: height,
                width: width,
                pageController: pageController,
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
                return ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10, right: 10),
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "Câu ${index + 1}: \n ${_models[index].question}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                for (int i = 0; i < 4; i++)
                                  Answer(
                                    i: i,
                                    choose: choose,
                                    listAnswer: listAnswer,
                                    color: color,
                                    index: index,
                                    styleAnswer: styleAnswer,
                                    onChanged: (String? value) {
                                      setState(() {
                                        choose[index] = value;
                                        updateAnswerColor(index, i);
                                      });
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
              drawer: MyDrawer(
                models: _models,
                listAnswer: listAnswer,
                pageController: pageController,
                color: color,
                choose: choose,
              ));
        });
  }
   void updateAnswerColor(int questionIndex, int selectedAnswerIndex) {
    setState(() {
      for (int i = 0; i < color[questionIndex].length; i++) {
        color[questionIndex][i] =
            (i == selectedAnswerIndex) ? Color.fromRGBO(255, 189, 189, 1) : Colors.white;
      }
    });
  }
}
