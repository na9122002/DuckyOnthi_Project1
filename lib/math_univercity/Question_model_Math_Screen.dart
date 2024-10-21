import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:travo_app_source/math_univercity/model_list_math.dart';
import 'package:travo_app_source/math_univercity/question_model_math.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/do_and_review_questions/ResultScreen.dart';

class QuesionMathModel extends StatefulWidget {
  const QuesionMathModel({Key? key, required this.topic}) : super(key: key);
  static const routeName = 'Question_model_English';
  final dynamic topic;
  @override
  State<QuesionMathModel> createState() => _QuesionMathModelState();
}

class _QuesionMathModelState extends State<QuesionMathModel> {
  List<Question_Model1>? _models;
  final PageController pageController = PageController();
  final StreamController<int> streamController = StreamController<int>();
  @override
  void initState() {
    _models = getListModelStory1(widget.topic);
    super.initState();
  }

  int quantityQ = 0;
  int time = 0;
  int Minutes = 0;
  int Seconds = 0;
  List<dynamic?> Choose = [];
  int mark = 0;
  int chooseF = 0;
  List<List<dynamic?>> listAnwer = [[]];
  _CreatListR(int i) {
    List<int> number = [
      0,
      1,
      2,
      3,
    ];
    List<dynamic?> listR = ['', '', '', ''];
    List<dynamic?> list = [
      _models![i].trueAnswer,
      _models![i].falseAnwer1,
      _models![i].falseAnwer2,
      _models![i].falseAnwer3,
    ];
    for (int j = 0; j < 4; j++) {
      int index = Random().nextInt(number.length);
      int randIndex = number[index];
      number.remove(randIndex);
      listR[j] = list[randIndex];
    }
    return listR;
  }

  _CreatNopBai(int quantityQ) {
    for (int i = 0; i < _models!.length; i++) {
      if (Choose[i] == _models![i].trueAnswer && _models![i].id != '-') {
        mark++;
      }
      if (Choose[i] != _models![i].trueAnswer &&
          Choose[i] != "" &&
          _models![i].id != '-') {
        chooseF++;
      }
    }

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => ResultScreen(
    //               mark: mark,
    //               chooseF: chooseF,
    //               M: Minutes,
    //               S: Seconds,
    //               topic: widget.topic,
    //               quantityQ: quantityQ,
    //               listAnwer: listAnwer,
    //               Choose: Choose,
    //               subject: 'Toán',
    //               time: time,
    //             )));
    for (int i = 0; i < _models!.length; i++) {
      Choose[i] = '';
    }
    ;
  }

  _imageMath(dynamic image) {
    if (image != "") {
      return Image.network('${image}');
    }
  }

  _textSelect(str) {
    str = str.replaceAll(r'frac', '\\frac');
    str = str.replaceAll(r'log', '\\log');
    str = str.replaceAll(r'left', '\\left');
    str = str.replaceAll(r'right', '\\right');
    str = str.replaceAll(r'prime', '\\prime');
    str = str.replaceAll(r'ln', '\\ln');
    str = str.replaceAll(r'int', '\\int');
    str = str.replaceAll(r'sin', '\\sin');
    str = str.replaceAll(r'bar', '\\bar');
    str = str.replaceAll(r'pi', '\\pi');
    str = str.replaceAll(r'vec', '\\vec');
    str = str.replaceAll(r'infty', '\\infty');
    str = str.replaceAll(r'sqrt', '\\sqrt');
    str = str.replaceAll(r'circ', '\\circ');
    return str;
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < _models!.length; i++) {
      _models![i].question = _textSelect(_models![i].question);
      _models![i].trueAnswer = _textSelect(_models![i].trueAnswer);
      _models![i].falseAnwer1 = _textSelect(_models![i].falseAnwer1);
      _models![i].falseAnwer2 = _textSelect(_models![i].falseAnwer2);
      _models![i].falseAnwer3 = _textSelect(_models![i].falseAnwer3);
    }
    if (_models!.length == 20) {
      time = 15;
      quantityQ = 20;
    } else if (_models!.length >= 50) {
      time = 60;
      quantityQ = 50;
    }
    for (int i = 0; i < _models!.length; i++) {
      setState(() {});
      Choose.add('');
    }
    for (int i = 0; i < _models!.length; i++) {
      dynamic listR = _CreatListR(i);
      listAnwer.add([]);
      for (int k = 0; k < 4; k++) {
        listAnwer[i].add(listR[k]);
      }
    }
    TextStyle StyleAwnser = TextStyle(color: Colors.black, fontSize: 30);
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
              _CreatNopBai(quantityQ);
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black,
        child: Row(
          children: [
            InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 5),
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
                        begin: Duration(minutes: time), end: Duration.zero),
                    onEnd: () {
                      _CreatNopBai(quantityQ);
                    },
                    builder:
                        (BuildContext context, Duration value, Widget? child) {
                      final minutes = value.inMinutes;
                      final seconds = value.inSeconds % 60;
                      Minutes = minutes;
                      Seconds = seconds;
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
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
                  margin: EdgeInsets.only(right: 0),
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
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 700,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: _models!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: GestureDetector(
                          child: NotificationListener<UserScrollNotification>(
                            child: ListView(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 80, bottom: 10, right: 10),
                                      child: Container(
                                        margin: EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        'Câu ${_models![index].id}:'),
                                                    Math.tex(
                                                      '${_models![index].question}',
                                                      mathStyle: MathStyle
                                                          .scriptscript,
                                                    ),

                                                    TeXView(
                                                      child: TeXViewColumn(
                                                          children: [
                                                            TeXViewInkWell(
                                                              id: "id_0",
                                                              child:
                                                                  TeXViewColumn(
                                                                      children: [
                                                                    TeXViewDocument(
                                                                      r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
                                                                    ),
                                                                    TeXViewContainer(
                                                                      child: TeXViewImage
                                                                          .network(
                                                                              'https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
                                                                      style:
                                                                          TeXViewStyle(
                                                                        margin:
                                                                            TeXViewMargin.all(10),
                                                                        borderRadius:
                                                                            TeXViewBorderRadius.all(20),
                                                                      ),
                                                                    ),
                                                                    TeXViewDocument(
                                                                        r"""<p>                                
                       When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                       $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
                                                                        style: TeXViewStyle.fromCSS(
                                                                            'padding: 15px; color: white; background: green'))
                                                                  ]),
                                                            )
                                                          ]),
                                                      style: TeXViewStyle(
                                                        elevation: 10,
                                                        borderRadius:
                                                            TeXViewBorderRadius
                                                                .all(25),
                                                        border: TeXViewBorder.all(
                                                            TeXViewBorderDecoration(
                                                                borderColor:
                                                                    Colors.blue,
                                                                borderStyle:
                                                                    TeXViewBorderStyle
                                                                        .solid,
                                                                borderWidth:
                                                                    5)),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),

                                                    // Text(
                                                    //   'You have pushed the button this many times:',
                                                    // ),
                                                    // Text(
                                                    //   '$_counter',
                                                    //   style: Theme.of(context).textTheme.headline4,
                                                    // ),

                                                    // Text(
                                                    //   'You have pushed the button this many times:',
                                                    // ),
                                                    // Text(
                                                    //   '$_counter',
                                                    //   style: Theme.of(context).textTheme.headline4,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: _imageMath(
                                                  '${_models![index].image}'),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(45),
                                                color: Color.fromRGBO(
                                                    255, 189, 189, 1),
                                              ),
                                              child: RadioListTile(
                                                groupValue: Choose[index],
                                                value: listAnwer[index][0],
                                                title: Math.tex(
                                                    '${listAnwer[index][0]}',
                                                    mathStyle:
                                                        MathStyle.display),
                                                onChanged: (dynamic? value) {
                                                  setState(() {
                                                    Choose[index] = value;
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
                                                    BorderRadius.circular(45),
                                              ),
                                              child: RadioListTile(
                                                groupValue: Choose[index],
                                                value: listAnwer[index][1],
                                                title: Math.tex(
                                                    '${listAnwer[index][1]}',
                                                    mathStyle:
                                                        MathStyle.display),
                                                onChanged: (dynamic? value) {
                                                  setState(() {
                                                    Choose[index] = value;
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
                                                    BorderRadius.circular(45),
                                              ),
                                              child: RadioListTile(
                                                groupValue: Choose[index],
                                                value: listAnwer[index][2],
                                                title: Math.tex(
                                                    '${listAnwer[index][2]}',
                                                    mathStyle:
                                                        MathStyle.display),
                                                onChanged: (dynamic? value) {
                                                  setState(() {
                                                    Choose[index] = value;
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
                                                    BorderRadius.circular(45),
                                              ),
                                              child: RadioListTile(
                                                groupValue: Choose[index],
                                                value: listAnwer[index][3],
                                                title: Math.tex(
                                                    '${listAnwer[index][3]}',
                                                    mathStyle:
                                                        MathStyle.display),
                                                onChanged: (dynamic? value) {
                                                  setState(() {
                                                    Choose[index] = value;
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
            ],
          ),
        ],
      ),
    );
  }
}
