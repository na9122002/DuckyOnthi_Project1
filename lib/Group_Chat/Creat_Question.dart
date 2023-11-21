import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/representation/BottomNavigationBar.dart';

class CreatQuestionScreen extends StatefulWidget {
  const CreatQuestionScreen({Key? key, required this.UserName})
      : super(key: key);
  final String UserName;
  @override
  State<CreatQuestionScreen> createState() => _CreatQuestionScreenState();
}

List<String> list = <String>[
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

class _CreatQuestionScreenState extends State<CreatQuestionScreen> {
  TextStyle styleList = TextStyle(fontSize: 20);
  DateTime TimeChat = DateTime.now();
  String dropdownValue = list.first;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  List<String> imageUrl = [];
  @override
  Widget build(BuildContext context) {
    dynamic ContainerImage;
    _Add_image(dynamic imageUrl, dynamic context, dynamic width) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: Color.fromRGBO(255, 189, 189, 1),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (file == null) return;
                      String uniqueFileName =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images_group_chat');
                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);
                      try {
                        await referenceImageToUpload.putFile(File(file.path));
                        String IMGURL =
                            await referenceImageToUpload.getDownloadURL();
                        imageUrl.add(IMGURL);
                        setState(() {
                          ContainerImage = Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          width: width / 3.5,
                                          height: width / 3.5,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  217, 217, 217, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                              AssetHelper.Push_Image),
                                        ),
                                      ),
                                      onTap: () =>
                                          _Add_image(imageUrl, context, width)),
                                  for (int i = 0; i < 2; i++)
                                    imageUrl.length >= i + 1
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              imageUrl[i],
                                              width: width / 3.5,
                                              height: width / 3.5,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Container(
                                              width: width / 3.5,
                                              height: width / 3.5,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      217, 217, 217, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                ],
                              ),
                              Row(
                                children: [
                                  for (int i = 2; i < 5; i++)
                                    imageUrl.length >= i + 1
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              imageUrl[i],
                                              width: width / 3.5,
                                              height: width / 3.5,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Container(
                                              width: width / 3.5,
                                              height: width / 3.5,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      217, 217, 217, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                ],
                              )
                            ],
                          );
                        });
                      } catch (error) {}
                    },
                    icon: Icon(Icons.image)),
                IconButton(
                    onPressed: () async {
                      if (imageUrl.length >= 5) {
                        Fluttertoast.showToast(
                          msg: 'Nhập tối đa 5 ảnh',
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 3, 2, 2),
                        );
                      } else {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.camera);
                        if (file == null) return;
                        String uniqueFileName =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images_group_chat');
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);
                        try {
                          await referenceImageToUpload.putFile(File(file.path));
                          String IMGURL =
                              await referenceImageToUpload.getDownloadURL();
                          imageUrl.add(IMGURL);
                          setState(() {
                            ContainerImage = Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            width: width / 3.5,
                                            height: width / 3.5,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 1),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                                AssetHelper.Push_Image),
                                          ),
                                        ),
                                        onTap: () => _Add_image(
                                            imageUrl, context, width)),
                                    for (int i = 0; i < 2; i++)
                                      imageUrl.length >= i + 1
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                imageUrl[i],
                                                width: width / 3.5,
                                                height: width / 3.5,
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Container(
                                                width: width / 3.5,
                                                height: width / 3.5,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    for (int i = 2; i < 5; i++)
                                      imageUrl.length >= i + 1
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                imageUrl[i],
                                                width: width / 3.5,
                                                height: width / 3.5,
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Container(
                                                width: width / 3.5,
                                                height: width / 3.5,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                  ],
                                )
                              ],
                            );
                          });
                        } catch (error) {}
                      }
                    },
                    icon: Icon(Icons.camera_alt_rounded)),
              ],
            ),
          ],
        ),
      );
    }

    _Show_image(dynamic imageUrl, dynamic width, dynamic context) {
      return imageUrl.length > 0
          ? Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            width: width / 3.5,
                            height: width / 3.5,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(217, 217, 217, 1),
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            child: Image.asset(AssetHelper.Push_Image),
                          ),
                        ),
                        onTap: () => _Add_image(imageUrl, context, width)),
                    for (int i = 0; i < 2; i++)
                      imageUrl.length >= i + 1
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                imageUrl[i],
                                width: width / 3.5,
                                height: width / 3.5,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: width / 3.5,
                                height: width / 3.5,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                    borderRadius: BorderRadius.circular(20)),
                                alignment: Alignment.center,
                              ),
                            ),
                  ],
                ),
                Row(
                  children: [
                    for (int i = 2; i < 5; i++)
                      imageUrl.length >= i + 1
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                imageUrl[i],
                                width: width / 3.5,
                                height: width / 3.5,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: width / 3.5,
                                height: width / 3.5,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                    borderRadius: BorderRadius.circular(20)),
                                alignment: Alignment.center,
                              ),
                            ),
                  ],
                )
              ],
            )
          : Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      i != 0
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: width / 3.5,
                                height: width / 3.5,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                    borderRadius: BorderRadius.circular(20)),
                                alignment: Alignment.center,
                              ),
                            )
                          : InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: width / 3.5,
                                  height: width / 3.5,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                      borderRadius: BorderRadius.circular(20)),
                                  alignment: Alignment.center,
                                  child: Image.asset(AssetHelper.Push_Image),
                                ),
                              ),
                              onTap: () => _Add_image(imageUrl, context, width),
                            )
                  ],
                ),
                Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: width / 3.5,
                          height: width / 3.5,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(217, 217, 217, 1),
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                        ),
                      ),
                  ],
                ),
              ],
            );
    }

    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    ContainerImage = _Show_image(imageUrl, width, context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          Container(
            width: width - 30,
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              children: [
                Text(
                  'Viết bài',
                  style: TextStyle(fontSize: 26, color: Colors.black),
                ),
                Spacer(),
                Image.asset(AssetHelper.Anh_viet_bai)
              ],
            ),
          ),
        ],
      ),
      body: StreamBuilder<User?>(builder: (context, snapshot) {
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton<String>(
                      dropdownColor: Color.fromRGBO(255, 189, 189, 1),
                      value: dropdownValue,
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
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )),
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
                  controller: content,
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
            ContainerImage,
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 140, right: 140, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(255, 189, 189, 1),
                ),
                child: TextButton(
                    onPressed: () async {
                      if (content.text != "") {
                        await createTask(snapshot);
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
      }),
    );
  }

  Future createTask(dynamic snapshot) async {
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
    final user = snapshot.data;
    final _user = User(
      IDUser: docIDs,
      content: content.text,
      image: imageUrl,
      time: formatDate(
          DateTime.now(), [dd, '/', mm, '/', yyyy, hh, '-', nn, '-', ss]),
      userName: widget.UserName,
      ShowTime: formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]),
    );
    final json = _user.toJson();
    FirebaseFirestore.instance
        .collection('_Group_Chat')
        .doc('${dropdownValue}')
        .collection('Question_Chat')
        .doc()
        .set(json);
  }
}

class User {
  final String IDUser;
  final String content;
  final List<String> image;
  final String time;
  final String userName;
  final String ShowTime;
  User(
      {required this.IDUser,
      required this.content,
      required this.image,
      required this.time,
      required this.userName,
      required this.ShowTime});
  Map<String, dynamic> toJson() => {
        'IDUser': IDUser,
        'content': content,
        'image': image,
        'time': time,
        'userName': userName,
        'ShowTime': ShowTime
      };
  static User fromJson(Map<String, dynamic> json) => User(
      IDUser: json['IDUser'],
      content: json['content'],
      image: json['image'],
      time: json['time'],
      userName: json['userName'],
      ShowTime: json['ShowTime']);
}
