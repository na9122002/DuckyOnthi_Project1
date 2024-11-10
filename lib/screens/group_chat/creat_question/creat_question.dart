import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/models/user_question.dart';
import 'package:travo_app_source/screens/group_chat/creat_question/creat_question_appbar.dart';
import 'package:travo_app_source/screens/group_chat/creat_question/creat_question_body.dart';
import 'package:travo_app_source/screens/representation/bottom_navigation_bar.dart';

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
        appBar: CreatQuestionAppbar(),
        body: CreatQuestionBody(
            dropdownValue: dropdownValue,
            content: content,
            createTask: createTask,
            ContainerImage: ContainerImage));
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
    final _user = UserQuestion(
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
