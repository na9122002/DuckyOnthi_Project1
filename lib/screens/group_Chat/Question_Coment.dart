import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/group_Chat/Main_Group_Chat.dart';
import 'package:travo_app_source/screens/representation/bottom_navigation_bar.dart';

class QuestionAndComentScreen extends StatefulWidget {
  const QuestionAndComentScreen({
    Key? key,
    required this.content,
    required this.image,
    required this.dropdownValue,
    required this.IDquestion,
    required this.userNamePost,
    required this.timeShow,
    required this.IDUser,
  }) : super(key: key);
  final String content;
  final List<dynamic> image;
  final String dropdownValue;
  final String IDquestion;
  final String userNamePost;
  final String timeShow;
  final String IDUser;
  @override
  State<QuestionAndComentScreen> createState() =>
      _QuestionAndComentScreenState();
}

_deleteQuestion(String id, String dropdownValue) async {
  await FirebaseFirestore.instance
      .collection('_Group_Chat')
      .doc('${dropdownValue}')
      .collection('Question_Chat')
      .doc('${id}')
      .delete();
}

class _QuestionAndComentScreenState extends State<QuestionAndComentScreen> {
  SampleItem? selectedMenu;
  TextEditingController comment = TextEditingController();
  DateTime TimeChat = DateTime.now();
  String imageUrl = '';
  TextStyle styleList = TextStyle(fontSize: 20);
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    List<dynamic> ListImage = [];
    for (int i = 0; i < widget.image.length; i++) ListImage.add(i);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          Container(
              width: width,
              alignment: Alignment.center,
              child: Text(
                'Bình luận',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ))
        ],
      ),
      body: ListView(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border(
                //   top: BorderSide(
                //       width: 2,
                //       color: Color.fromRGBO(0, 0, 0, 0.5)),
                //   bottom: BorderSide(
                //       width: 2,
                //       color: Color.fromRGBO(0, 0, 0, 0.5)),
                // ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey,
                                ),
                                alignment: Alignment.topCenter,
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      AssetHelper.pika,
                                    ))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${widget.userNamePost}',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text('${widget.timeShow}'),
                          Spacer(),
                          PopupMenuButton<SampleItem>(
                            initialValue: selectedMenu,
                            onSelected: (SampleItem item) async {
                              dynamic IDUser1;
                              final Users = FirebaseAuth.instance.currentUser;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .where('email', isEqualTo: '${Users?.email}')
                                  .get()
                                  .then((snapshot) =>
                                      snapshot.docs.forEach((document) {
                                        IDUser1 = document.reference.id;
                                      }));
                              if (widget.IDUser == IDUser1) {
                                _deleteQuestion(
                                    widget.IDquestion, widget.dropdownValue);
                                Fluttertoast.showToast(
                                  msg: 'Bạn đã xóa 1 bài viết',
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Color.fromARGB(255, 3, 2, 2),
                                );
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      'Bạn không thể xóa bài viết của người khác',
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Color.fromARGB(255, 3, 2, 2),
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<SampleItem>>[
                              const PopupMenuItem<SampleItem>(
                                value: SampleItem.itemOne,
                                child: Text('Xóa bài viết'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${widget.content}',
                        style: TextStyle(fontSize: 20),
                      ),
                      widget.image.length != 0
                          ? CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: height / 2.85,
                                enableInfiniteScroll: false,
                              ),
                              items: ListImage.map((i) {
                                return Stack(
                                  children: [
                                    Builder(
                                      builder: (BuildContext context) {
                                        return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 22, left: 22),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: height / 2,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${widget.image[i]}'),
                                                      fit: BoxFit.fill)),
                                            ));
                                      },
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      padding: EdgeInsets.only(
                                          right: 35, bottom: 10),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 6,
                                            bottom: 6,
                                            right: 12,
                                            left: 12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.3)),
                                        child: Text(
                                          '${i + 1}/${ListImage.length}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('_Group_Chat')
                            .doc('${widget.dropdownValue}')
                            .collection('Question_Chat')
                            .doc('${widget.IDquestion}')
                            .collection('comment')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final snap = snapshot.data!.docs;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 22, left: 22),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                    child: Container(
                                      height: 62,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: width / 3,
                                              child: Row(
                                                children: [
                                                  Image.asset(AssetHelper.Like),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '0',
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                            width: width / 3,
                                            child: InkWell(
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      AssetHelper.Comment),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${snap.length}',
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                  ),
                                                ],
                                              ),
                                              onTap: () async {},
                                            ),
                                          ),
                                          Image.asset(AssetHelper.Chia_se),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '0',
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('_Group_Chat')
                .doc('${widget.dropdownValue}')
                .collection('Question_Chat')
                .doc('${widget.IDquestion}')
                .collection('comment')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.docs;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        List<dynamic> ListImage = [];
                        for (int i = 0; i < widget.image.length; i++)
                          ListImage.add(i);
                        return Container(
                          // width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border(
                            //   top: BorderSide(
                            //       width: 2,
                            //       color: Color.fromRGBO(0, 0, 0, 0.5)),
                            //   bottom: BorderSide(
                            //       width: 2,
                            //       color: Color.fromRGBO(0, 0, 0, 0.5)),
                            // ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey,
                                      ),
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          height: 60,
                                          width: 60,
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            AssetHelper.pika,
                                          ))),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: width - 100,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${snap[index]['userName']}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  PopupMenuButton<SampleItem>(
                                                    initialValue: selectedMenu,
                                                    onSelected: (SampleItem
                                                        item) async {
                                                      dynamic IDComment;
                                                      dynamic docIDs;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              '_Group_Chat')
                                                          .doc(
                                                              '${widget.dropdownValue}')
                                                          .collection(
                                                              'Question_Chat')
                                                          .doc(
                                                              '${widget.IDquestion}')
                                                          .collection('comment')
                                                          .where('time',
                                                              isEqualTo:
                                                                  '${snap[index]['time']}')
                                                          .get()
                                                          .then((snapshot) =>
                                                              snapshot.docs
                                                                  .forEach(
                                                                      (document) {
                                                                IDComment =
                                                                    document
                                                                        .reference
                                                                        .id;
                                                              }));
                                                      final Users = FirebaseAuth
                                                          .instance.currentUser;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .where('email',
                                                              isEqualTo:
                                                                  '${Users?.email}')
                                                          .get()
                                                          .then((snapshot) =>
                                                              snapshot.docs
                                                                  .forEach(
                                                                      (document) {
                                                                print(document
                                                                    .reference);
                                                                docIDs = document
                                                                    .reference
                                                                    .id;
                                                              }));
                                                      if (docIDs ==
                                                          snap[index]
                                                              ['IDuser']) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                '_Group_Chat')
                                                            .doc(
                                                                '${widget.dropdownValue}')
                                                            .collection(
                                                                'Question_Chat')
                                                            .doc(
                                                                '${widget.IDquestion}')
                                                            .collection(
                                                                'comment')
                                                            .doc('${IDComment}')
                                                            .delete();
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              'Bạn đã khóa một bình luận',
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255, 3, 2, 2),
                                                        );
                                                      } else {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              'Bạn không thể xóa bình luận của người khác',
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255, 3, 2, 2),
                                                        );
                                                      }
                                                    },
                                                    itemBuilder: (BuildContext
                                                            context) =>
                                                        <
                                                            PopupMenuEntry<
                                                                SampleItem>>[
                                                      const PopupMenuItem<
                                                          SampleItem>(
                                                        value:
                                                            SampleItem.itemOne,
                                                        child: Text(
                                                            'Xóa bình luận'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 80),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '${snap[index]['comment']}',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 80),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${snap[index]['ShowTime']}',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<User?>(builder: (context, snapshot) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                    width: 3, color: Color.fromARGB(255, 188, 188, 188)),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print('${file?.path}');
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

                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {}
                      },
                      icon: Icon(Icons.image)),
                  Expanded(
                    child: TextField(
                      controller: comment,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Thêm bình luận",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (comment.text != '') {
                        await createComent(snapshot);
                        Fluttertoast.showToast(
                          msg: 'Bạn đã bình luận 1 câu hỏi',
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 3, 2, 2),
                        );
                        comment.text = '';
                        imageUrl = '';
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Bạn hãy nhập bình luận',
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 3, 2, 2),
                        );
                      }
                    },
                    icon: Image.asset(AssetHelper.SEND),
                  )
                ],
              ),
            ));
      }),
    );
  }

  Future createComent(dynamic snapshot) async {
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
    final docUser = FirebaseFirestore.instance.collection('users').doc(docIDs);
    final snapshot1 = await docUser.get();

    final _user = User(
      comment: comment.text,
      image: imageUrl,
      time: TimeChat.toString(),
      userName: User1.fromJson(snapshot1.data()!).TenDangNhap,
      IDuser: docIDs,
      ShowTime: formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]),
    );
    final json = _user.toJson();

    FirebaseFirestore.instance
        .collection('_Group_Chat')
        .doc('${widget.dropdownValue}')
        .collection('Question_Chat')
        .doc('${widget.IDquestion}')
        .collection('comment')
        .doc()
        .set(json);
  }
}

class User {
  final String comment;
  final String image;
  final String time;
  final String userName;
  final String IDuser;
  final String ShowTime;

  User({
    required this.comment,
    required this.image,
    required this.time,
    required this.userName,
    required this.IDuser,
    required this.ShowTime,
  });
  Map<String, dynamic> toJson() => {
        'comment': comment,
        'image': image,
        'time': time,
        'userName': userName,
        'IDuser': IDuser,
        'ShowTime': ShowTime
      };

  static User fromJson(Map<String, dynamic> json) => User(
      comment: json['comment'],
      image: json['image'],
      time: json['time'],
      userName: json['userName'],
      IDuser: json['IDuser'],
      ShowTime: json['ShowTime']);
}

class User1 {
  String id;
  final String TenDangNhap;
  final String Sodienthoai;
  final String email;
  final String MatKhau;

  User1({
    this.id = '',
    required this.TenDangNhap,
    required this.Sodienthoai,
    required this.email,
    required this.MatKhau,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'TenDangNhap': TenDangNhap,
        'Sodienthoai': Sodienthoai,
        'email': email,
        'Matkhau': MatKhau,
      };

  static User1 fromJson(Map<String, dynamic> json) => User1(
      id: json['id'],
      TenDangNhap: json['TenDangNhap'],
      Sodienthoai: json['Sodienthoai'],
      email: json['email'],
      MatKhau: json['Matkhau']);
}
