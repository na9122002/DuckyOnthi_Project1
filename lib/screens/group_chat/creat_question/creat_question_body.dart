import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travo_app_source/models/user_question.dart';
import 'package:travo_app_source/screens/group_chat/creat_question/creat_question.dart';
import 'package:travo_app_source/screens/representation/bottom_navigation_bar.dart';

class CreatQuestionBody extends StatefulWidget {
  dynamic dropdownValue;
  final dynamic content;
  final dynamic createTask;
  final dynamic ContainerImage;
 CreatQuestionBody({Key? key,required this.dropdownValue,required this.content,required this.createTask,required this.ContainerImage}) : super(key: key);

  @override
  State<CreatQuestionBody> createState() => _CreatQuestionBodyState();
}

class _CreatQuestionBodyState extends State<CreatQuestionBody> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return StreamBuilder<UserQuestion?>(builder: (context, snapshot) {
        return ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(right: width / 1.6),
              child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(255, 189, 189, 1),
                  ),
                  margin: const EdgeInsets.only(left: 20),
                  alignment: Alignment.center,
                  child: DropdownButton<String>(
                      dropdownColor: Color.fromRGBO(255, 189, 189, 1),
                      value: widget.dropdownValue,
                      icon: const Icon(
                        Icons.expand_more,
                        color: Colors.black,
                      ),
                      elevation: 16,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          widget.dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                height: 334,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TextField(
                  controller: widget.content,
                  decoration: InputDecoration(
                    labelText: 'Nhập Nội Dung....',
                  ),
                  maxLines: 16,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            widget.ContainerImage,
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 100, right: 100, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(255, 189, 189, 1),
                ),
                child: TextButton(
                    onPressed: () async {
                      if (widget.content.text != "") {
                        await widget.createTask(snapshot);
                        Fluttertoast.showToast(
                          msg: 'Tạo câu hỏi thành công',
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 3, 2, 2),
                        );
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Vui lòng điền đầy đủ thông tin để tạo câu hỏi',
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 3, 2, 2),
                        );
                      }
                    },
                    child: Text('ĐĂNG',
                        style: TextStyle(color: Colors.black, fontSize: 25))),
              ),
            ),
          ],
        );
      });
  }
  
}