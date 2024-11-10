import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_app_source/models/user_achievement_board.dart';
import 'package:travo_app_source/models/user_work_done_model.dart';
import 'package:travo_app_source/network/blocs/question_bloc.dart';
import 'package:travo_app_source/network/models_api/item_api_model.dart';
import 'package:travo_app_source/screens/do_and_review_questions/result/result_screen.dart';

class QuestionController{
  static Future<UserAchievementBoard?> readDATA(String MonthTime, String subject) async {
  try {
    final Users = FirebaseAuth.instance.currentUser;
    if (Users == null) {
      print("User is not logged in");
      return null;
    }

    // Tìm ID người dùng
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: Users.email)
        .get();

    if (userSnapshot.docs.isEmpty) {
      print("User not found");
      return null;
    }

    final docIDs = userSnapshot.docs.first.id;

    // Lấy dữ liệu từ Achievement_Board
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(docIDs)
        .collection('Achievement_Board')
        .doc(MonthTime)
        .collection(MonthTime)
        .doc(subject);

    final snapshot = await docUser.get();

    if (!snapshot.exists) {
      return null;
    }

    // Kiểm tra xem data có tồn tại không trước khi sử dụng
    final data = snapshot.data();
    if (data == null) {
      print("No data found in the document");
      return null;
    }

    return UserAchievementBoard.fromJson(data);
  } catch (e) {
    print("Error reading data: $e");
    return null;
  }
}

 static  creatListR(int i, List<ItemModel> _models) {
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

 static  creatNopBai(int quantityQ, dynamic snapshot,
      dynamic hoursSpent, dynamic _models, dynamic choose,dynamic mark,dynamic chooseF,dynamic context,dynamic listAnswer, dynamic listItem){
    for (int i = 0; i < _models.length; i++) {
      if (choose[i] == _models[i].trueAnwer && _models[i].id != '-') {
        mark++;
      }
      if (choose[i] != _models[i].trueAnwer &&
          choose[i] != "" &&
          _models[i].id != '-') {
        chooseF++;
      }
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(
                  mark: mark,
                  chooseF: chooseF,
                  topic: 'topc2',
                  quantityQ: quantityQ,
                  listAnwer: listAnswer,
                  Choose: choose,
                  subject: 'Tiếng Anh',
                  time: hoursSpent,
                  listItem: listItem,
                )));
  }


 static createWorkDone(
      dynamic snapshot,
      String subject,
      String Time,
      int FalseAnwer,
      dynamic listAnswer,
      String Topic,
      int TrueAnswer,
      int NumberAnswer,
      dynamic ListQuestion,
      dynamic ListTrueAnswer,dynamic choose) async {
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
      TotalTime: 0,
      FalseAnwer: FalseAnwer,
      TrueAnswer: TrueAnswer,
      NumberAnswer: NumberAnswer,
      listAnswer: choose,
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

 static  creatAchievementBoard(dynamic choose,dynamic MonthTime,dynamic practice_second, dynamic _models) async {
    int trueAnswerNow = 0;
    int falseAnwerNow = 0;
    for (int i = 0; i < _models!.length; i++) {
      if (choose[i] == _models![i].trueAnwer && _models![i].id != '-') {
        trueAnswerNow++;
      }
      if (choose[i] != _models![i].trueAnwer &&
          choose[i] != "" &&
          _models![i].id != '-') {
        falseAnwerNow++;
      }
    }

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
    final user = UserAchievementBoard(
        total_practice_second: FieldValue.increment(practice_second),
        number_true_answer: FieldValue.increment(trueAnswerNow),
        number_false_answer: FieldValue.increment(falseAnwerNow));
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(docIDUser)
        .collection('Achievement_Board')
        .doc(MonthTime)
        .collection(MonthTime)
        .doc('Tiếng Anh');

    final json = user.toJson();
    await docUser.set(json, SetOptions(merge: true));
  }

}