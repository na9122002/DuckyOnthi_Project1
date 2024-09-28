import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travo_app_source/english_class_univercity/model_list.dart';
import 'package:travo_app_source/english_class_univercity/question_model.dart';

class ReviewQuestionScreen extends StatefulWidget {
  const ReviewQuestionScreen(
      {Key? key,
      required this.topic,
      required this.listAnwer,
      required this.Choose})
      : super(key: key);
  final String topic;
  final dynamic listAnwer;
  final dynamic Choose;
  @override
  State<ReviewQuestionScreen> createState() => _ReviewQuestionScreenState();
}

class _ReviewQuestionScreenState extends State<ReviewQuestionScreen> {
  List<Question_Model>? _models;
  final PageController pageController = PageController();
  final StreamController<int> streamController = StreamController<int>();
  @override
  void initState() {
    _models = getListModelStory(widget.topic);
    super.initState();
    pageController.addListener(() {
      pageController.addListener(() {
        streamController.add(pageController.page!.toInt());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color _color = Colors.white;
    TextStyle StyleAwnser = TextStyle(color: Colors.black, fontSize: 20);
    return Scaffold(
      bottomNavigationBar: GridView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 5,
          childAspectRatio: 2,
        ),
        children: [
          for (int i = 0; i < _models!.length; i++)
            Container(
              color: widget.Choose[i] == ""
                  ? _color = Colors.white
                  : widget.Choose[i] != _models![i].trueAnswer
                      ? _color = Colors.red
                      : _color = Colors.green,
              child: Row(
                children: [
                  TextButton(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: Colors.black,
                          // fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      onPressed: () {
                        pageController.jumpToPage(i);
                      }),
                ],
              ),
            ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
        title: Text(
          'Xem lại bài thi',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 900,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: _models!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: GestureDetector(
                          child: NotificationListener<UserScrollNotification>(
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
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
                                              child: Text(
                                                "Câu ${_models![index].id}:\n  ${_models![index].question}",
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
                                                    BorderRadius.circular(45),
                                                color: Color.fromRGBO(
                                                    255, 189, 189, 1),
                                              ),
                                              child: RadioListTile(
                                                activeColor: Colors.black,
                                                groupValue:
                                                    _models![index].trueAnswer,
                                                value:
                                                    '${widget.listAnwer[index][0]}',
                                                title: widget.listAnwer[index]
                                                            [0] !=
                                                        _models![index]
                                                            .trueAnswer
                                                    ? widget.listAnwer[index]
                                                                [0] !=
                                                            widget.Choose[index]
                                                        ? Text(
                                                            '${widget.listAnwer[index][0]}',
                                                            style: StyleAwnser,
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                                Text(
                                                                    '${widget.listAnwer[index][0]}',
                                                                    style:
                                                                        StyleAwnser),
                                                                Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 40,
                                                                )
                                                              ])
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                            Text(
                                                                '${widget.listAnwer[index][0]}',
                                                                style:
                                                                    StyleAwnser),
                                                            Icon(
                                                              Icons.check_box,
                                                              color:
                                                                  Colors.green,
                                                              size: 40,
                                                            )
                                                          ]),
                                                onChanged: (String? value) {},
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
                                                activeColor: Colors.black,
                                                groupValue:
                                                    _models![index].trueAnswer,
                                                value:
                                                    '${widget.listAnwer[index][1]}',
                                                title: widget.listAnwer[index]
                                                            [1] !=
                                                        _models![index]
                                                            .trueAnswer
                                                    ? widget.listAnwer[index]
                                                                [1] !=
                                                            widget.Choose[index]
                                                        ? Text(
                                                            '${widget.listAnwer[index][1]}',
                                                            style: StyleAwnser,
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                                Text(
                                                                    '${widget.listAnwer[index][1]}',
                                                                    style:
                                                                        StyleAwnser),
                                                                Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 40,
                                                                )
                                                              ])
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                            Text(
                                                                '${widget.listAnwer[index][1]}',
                                                                style:
                                                                    StyleAwnser),
                                                            Icon(
                                                              Icons.check_box,
                                                              color:
                                                                  Colors.green,
                                                              size: 40,
                                                            )
                                                          ]),
                                                onChanged: (String? value) {
                                                  setState(() {});
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
                                                activeColor: Colors.black,
                                                groupValue:
                                                    _models![index].trueAnswer,
                                                value:
                                                    '${widget.listAnwer[index][2]}',
                                                title: widget.listAnwer[index]
                                                            [2] !=
                                                        _models![index]
                                                            .trueAnswer
                                                    ? widget.listAnwer[index]
                                                                [2] !=
                                                            widget.Choose[index]
                                                        ? Text(
                                                            '${widget.listAnwer[index][2]}',
                                                            style: StyleAwnser,
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                                Text(
                                                                    '${widget.listAnwer[index][2]}',
                                                                    style:
                                                                        StyleAwnser),
                                                                Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 40,
                                                                )
                                                              ])
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                            Text(
                                                                '${widget.listAnwer[index][2]}',
                                                                style:
                                                                    StyleAwnser),
                                                            Icon(
                                                              Icons.check_box,
                                                              color:
                                                                  Colors.green,
                                                              size: 40,
                                                            )
                                                          ]),
                                                onChanged: (String? value) {
                                                  setState(() {});
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
                                                activeColor: Colors.black,
                                                groupValue:
                                                    _models![index].trueAnswer,
                                                value:
                                                    '${widget.listAnwer[index][3]}',
                                                title: widget.listAnwer[index]
                                                            [3] !=
                                                        _models![index]
                                                            .trueAnswer
                                                    ? widget.listAnwer[index]
                                                                [3] !=
                                                            widget.Choose[index]
                                                        ? Text(
                                                            '${widget.listAnwer[index][3]}',
                                                            style: StyleAwnser,
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                                Text(
                                                                    '${widget.listAnwer[index][3]}',
                                                                    style:
                                                                        StyleAwnser),
                                                                Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 40,
                                                                )
                                                              ])
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                            Text(
                                                                '${widget.listAnwer[index][3]}',
                                                                style:
                                                                    StyleAwnser),
                                                            Icon(
                                                              Icons.check_box,
                                                              color:
                                                                  Colors.green,
                                                              size: 40,
                                                            )
                                                          ]),
                                                onChanged: (String? value) {
                                                  setState(() {});
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
