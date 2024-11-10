import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/models/question_and_comment.dart';
import 'package:travo_app_source/screens/group_chat/question_comment/question_comment.dart';

class QuestionCommentBottom extends StatefulWidget {
  QuestionCommentBottom({Key? key, required this.imageUrl,required this.comment,required this.TimeChat,required this.dropdownValue, required this.IDquestion}) : super(key: key);
  late final dynamic imageUrl;
  final dynamic comment;
  final dynamic TimeChat;
  final dynamic dropdownValue;
  final dynamic IDquestion;
  @override
  State<QuestionCommentBottom> createState() => _QuestionCommentBottomState();
}

class _QuestionCommentBottomState extends State<QuestionCommentBottom> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(builder: (context, snapshot) {
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
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images_group_chat');
                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);
                      try {
                        await referenceImageToUpload.putFile(File(file.path));

                        widget.imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {}
                    },
                    icon: Icon(Icons.image)),
                Expanded(
                  child: TextField(
                    controller: widget.comment,
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
                    if (widget.comment.text != '') {
                      await createComent(snapshot);
                      Fluttertoast.showToast(
                        msg: 'Bạn đã bình luận 1 câu hỏi',
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 3, 2, 2),
                      );
                      widget.comment.text = '';
                      widget.imageUrl = '';
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
    });
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

    final _user = QuestionAndComment.QuestionAndComment(
      comment: widget.comment.text,
      image: widget.imageUrl,
      time: widget.TimeChat.toString(),
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
