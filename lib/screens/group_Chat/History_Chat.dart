import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/group_chat/Main_Group_Chat.dart';
import 'package:travo_app_source/screens/group_chat/Question_Coment.dart';
class HistoryChatSceen extends StatefulWidget {
  const HistoryChatSceen({Key? key}) : super(key: key);
  @override
  State<HistoryChatSceen> createState() => _HistoryChatSceenState();
}
String IDUser1 = '';
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
_deleteQuestion(String id, String dropdownValue) async {
  await FirebaseFirestore.instance
      .collection('_Group_Chat')
      .doc('${dropdownValue}')
      .collection('Question_Chat')
      .doc('${id}')
      .delete();
}
futureInt() async {
  final Users1 = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: '${Users1?.email}')
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
            IDUser1 = document.reference.id;
          }));
}
class _HistoryChatSceenState extends State<HistoryChatSceen> {
  String dropdownValue = list.first;
  Widget build(BuildContext context) {
    dynamic docIDPost;
    SampleItem? selectedMenu;
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final Users1 = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: '${Users1?.email}')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              IDUser1 = document.reference.id;
            }));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                    'Lịch sử',
                    style: TextStyle(fontSize: 26, color: Colors.black),
                  ),
                  Spacer(),
                  Image.asset(AssetHelper.iconHistory)
                ],
              ),
            ),
          ],
 
        ),
        body: 
            ListView(  
              children: [              
                  Padding(
                    padding: const EdgeInsets.only(top:8,left: 8,bottom: 8,right: 230),
                    child: Container(                                  
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 189, 189, 1),
                        borderRadius: BorderRadius.circular(20),                        
                      ),
                      child:DropdownButton<String>(                          
                          // dropdownColor: Color.fromRGBO(255, 189, 189, 1),
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.expand_more,
                            color: Colors.black,
                            size: 30,
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
                            print('${IDUser1}');
                          },
                          items:
                              list.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ), 
                    ),
                  ),              
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('_Group_Chat')
                      .doc('${dropdownValue}')
                      .collection('Question_Chat')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          if (snap[index]['IDUser'] == IDUser1) {
                            FirebaseFirestore.instance
                                .collection('_Group_Chat')
                                .doc('${dropdownValue}')
                                .collection('Question_Chat')
                                .where('time',
                                    isEqualTo: '${snap[index]['time']}')
                                .get()
                                .then((snapshot) =>
                                    snapshot.docs.forEach((document) {
                                      DocumentIDcomment.add(
                                          document.reference.id);
                                    }));
                            List<dynamic> ListImage = [];
                            for (int i = 0;
                                i < snap[index]['image'].length;
                                i++) ListImage.add(i);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 22),
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(2, 2),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 10),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        child: Image.asset(
                                                          AssetHelper.pika,
                                                        )),
                                                  )),
                                            ),
                                           
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${snap[index]['userName']}',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                   Text(
                                                '${snap[index]['ShowTime']}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                ),
                                              ),
                                                ],
                                              ),
                                            ),
                                           
                                        
                                          Flexible(
                                              child: PopupMenuButton<SampleItem>(
                                                initialValue: selectedMenu,
                                                onSelected:
                                                    (SampleItem item) async {
                                                  dynamic IDUser;
                                                  final Users = FirebaseAuth
                                                      .instance.currentUser;
                                                  await FirebaseFirestore.instance
                                                      .collection('users')
                                                      .where('email',
                                                          isEqualTo:
                                                              '${Users?.email}')
                                                      .get()
                                                      .then((snapshot) =>
                                                          snapshot.docs.forEach(
                                                              (document) {
                                                            IDUser = document
                                                                .reference.id;
                                                          }));
                                                  await FirebaseFirestore.instance
                                                      .collection('_Group_Chat')
                                                      .doc('${dropdownValue}')
                                                      .collection('Question_Chat')
                                                      .where('time',
                                                          isEqualTo:
                                                              '${snap[index]['time']}')
                                                      .get()
                                                      .then((snapshot) =>
                                                          snapshot.docs.forEach(
                                                              (document) {
                                                            print(document
                                                                .reference);
                                                            setState(() {
                                                              docIDPost = document
                                                                  .reference.id;
                                                            });
                                                          }));
                                                  if (snap[index]['IDUser'] ==
                                                      IDUser) {
                                                    _deleteQuestion(
                                                        docIDPost, dropdownValue);
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'Bạn đã xóa 1 bài viết',
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 3, 2, 2),
                                                    );
                                                  } else {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'Bạn không thể xóa bài viết của người khác',
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 3, 2, 2),
                                                    );
                                                  }
                                                },
                                                itemBuilder: (BuildContext
                                                        context) =>
                                                    <PopupMenuEntry<SampleItem>>[
                                                  const PopupMenuItem<SampleItem>(
                                                    value: SampleItem.itemOne,
                                                    child: Text('Xóa bài viết'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            '${snap[index]['content']}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListImage.length != 0
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
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 22,
                                                                    left: 22),
                                                            child: Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height:
                                                                  height / 1.5,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5.0),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          '${snap[index]['image'][i]}'),
                                                                      fit: BoxFit
                                                                          .fill)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 35,
                                                                bottom: 10),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 6,
                                                                  bottom: 6,
                                                                  right: 12,
                                                                  left: 12),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.3)),
                                                          child: Text(
                                                            '${i + 1}/${ListImage.length}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }).toList(),
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('_Group_Chat')
                                              .doc('${dropdownValue}')
                                              .collection('Question_Chat')
                                              .doc(
                                                  '${DocumentIDcomment[index]}')
                                              .collection('comment')
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot1) {
                                            if (snapshot1.hasData) {
                                              final snap1 =
                                                  snapshot1.data!.docs;

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 22,
                                                            left: 22),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        height: 62,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                width:
                                                                    width / 3,
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        AssetHelper
                                                                            .Like),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      '0',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22),
                                                                    ),
                                                                  ],
                                                                )),
                                                            Container(
                                                              width: width / 3,
                                                              child: InkWell(
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        AssetHelper
                                                                            .Comment),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      '${snap1.length}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22),
                                                                    ),
                                                                  ],
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  dynamic
                                                                      docIDDelete;
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          '_Group_Chat')
                                                                      .doc(
                                                                          '${dropdownValue}')
                                                                      .collection(
                                                                          'Question_Chat')
                                                                      .where(
                                                                          'time',
                                                                          isEqualTo:
                                                                              '${snap[index]['time']}')
                                                                      .get()
                                                                      .then((snapshot) =>
                                                                          snapshot
                                                                              .docs
                                                                              .forEach((document) {
                                                                            print(document.reference);

                                                                            docIDDelete =
                                                                                document.reference.id;
                                                                          }));

                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => QuestionAndComentScreen(
                                                                                timeShow: snap[index]['ShowTime'],
                                                                                content: snap[index]['content'],
                                                                                image: snap[index]['image'],
                                                                                userNamePost: snap[index]['userName'],
                                                                                IDquestion: DocumentIDcomment[index],
                                                                                dropdownValue: dropdownValue,
                                                                                IDUser: snap[index]['IDUser'],
                                                                              )));
                                                                },
                                                              ),
                                                            ),
                                                            Image.asset(
                                                                AssetHelper
                                                                    .Chia_se),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '0',
                                                              style: TextStyle(
                                                                  fontSize: 22),
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
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
            // Container(),
            // Container(),
        
      ),
    );
  }
}
