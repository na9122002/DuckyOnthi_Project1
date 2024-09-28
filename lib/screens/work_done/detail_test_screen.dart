import 'package:flutter/material.dart';

class DetailTestScreen extends StatefulWidget {
  const DetailTestScreen(
      {Key? key,
      required this.TrueAnswer,
      required this.NumberAnswer,
      required this.Time,
      required this.TotalTime,
      required this.falseAnwer,
      required this.Choose,
      required this.ListQuestion,
      required this.ListTrueAnswer})
      : super(key: key);
  final dynamic TrueAnswer;
  final dynamic NumberAnswer;
  final dynamic Time;
  final dynamic TotalTime;
  final dynamic falseAnwer;
  final dynamic ListQuestion;
  final dynamic ListTrueAnswer;

  final dynamic Choose;
  @override
  State<DetailTestScreen> createState() => _DetailTestScreenState();
}

class _DetailTestScreenState extends State<DetailTestScreen> {
  TextStyle styleResult =
      TextStyle(fontStyle: FontStyle.normal, fontSize: 15, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    double ratio = (widget.TrueAnswer * 100) / widget.NumberAnswer;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 189, 189, 1),
        title: Text(
          'Kết quả luyện tập',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: Colors.black,
                            size: 30,
                          ),
                          Text(
                              'Kết quả\nlàm bài\n${widget.TrueAnswer}/${widget.NumberAnswer}',
                              style: styleResult),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.flaky,
                            color: Colors.black,
                            size: 30,
                          ),
                          Text(
                              'Độ chính \nxác\n ${ratio.toStringAsFixed(0)}/100 ',
                              style: styleResult),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.black,
                            size: 30,
                          ),
                          Text(
                              'Thời gian \n còn lại\n ${widget.Time}/${widget.TotalTime}(phút)',
                              style: styleResult),
                        ],
                      )),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(right: 10, left: 14, top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        top: BorderSide(width: 5, color: Colors.green),
                        left: BorderSide(width: 5, color: Colors.green),
                        right: BorderSide(width: 5, color: Colors.green),
                        bottom: BorderSide(width: 5, color: Colors.green),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.TrueAnswer}',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Text('Trả lời đúng')
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(right: 10, left: 14, top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        top: BorderSide(width: 5, color: Colors.red),
                        left: BorderSide(width: 5, color: Colors.red),
                        right: BorderSide(width: 5, color: Colors.red),
                        bottom: BorderSide(width: 5, color: Colors.red),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.falseAnwer}',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Text('Trả lời sai')
                ],
              ),
              // Column(
              //   children: [
              //     Container(
              //       height: 50,
              //       width: 50,
              //       margin: EdgeInsets.only(right: 10, left: 14, top: 8),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border(
              //           top: BorderSide(width: 5, color: Colors.grey),
              //           left: BorderSide(width: 5, color: Colors.grey),
              //           right: BorderSide(width: 5, color: Colors.grey),
              //           bottom: BorderSide(width: 5, color: Colors.grey),
              //         ),
              //       ),
              //       child: Container(
              //         alignment: Alignment.center,
              //         child: Text(
              //           '${widget.NumberAnswer - widget.TrueAnswer - widget.falseAnwer}',
              //           style: TextStyle(
              //               color: Colors.grey,
              //               fontSize: 30,
              //               fontWeight: FontWeight.w800),
              //         ),
              //       ),
              //     ),
              //     Text('Câu bỏ qua')
              //   ],
              // ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: widget.ListQuestion.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Câu ${index + 1}: ${widget.ListQuestion[index]}'),
                    widget.ListTrueAnswer[index] != widget.Choose[index]
                        ? Column(
                            children: [
                              Text(
                                '${widget.ListTrueAnswer[index]}\n',
                                style: TextStyle(color: Colors.green),
                              ),
                              Text('${widget.Choose[index]}\n',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          )
                        : Text('${widget.ListTrueAnswer[index]}')
                  ],
                );
              })
        ],
      ),
    );
  }
}
