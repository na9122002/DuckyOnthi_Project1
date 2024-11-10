import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/light_and_dark.dart/change_theme_button_widget.dart';
import 'package:travo_app_source/not_update.dart';
import 'package:travo_app_source/screens/scheledu/main_scheledu/main_scheledu_screen.dart';
import 'package:travo_app_source/screens/achievements_chart_screen.dart';
import 'package:travo_app_source/screens/work_done/main_work_done_screen.dart';
import 'package:travo_app_source/models/users_model.dart' as users_model;
import 'package:travo_app_source/widget/inwell_users.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  static String routeName = "UsersScreen";
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  _notUpDate(String function) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OthersubjectScreen(subject: function)));
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  var size, height, width;
  bool light = true;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return FutureBuilder<users_model.User?>(
        future: readUser(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(AssetHelper.image_user),
                  Padding(
                    padding: EdgeInsets.only(top: height / 4.5, left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                height: 120,
                                width: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 90,
                                      width: 90,
                                      child: Image.asset(AssetHelper.pika)),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Chào ${user?.username}',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                  ),
                  children: [
                    InwellUsers(
                      image: AssetHelper.bai_da_lam,
                      label: 'Bài đã\n làm',
                      onTap: () async {
                        dynamic docIDs;
                        final Users = FirebaseAuth.instance.currentUser;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .where('email', isEqualTo: '${Users?.email}')
                            .get()
                            .then(
                                (snapshot) => snapshot.docs.forEach((document) {
                                      print(document.reference);
                                      docIDs = document.reference.id;
                                    }));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => MainWorkDoneScreen(
                                      docIDs: docIDs,
                                    )));
                      },
                    ),
                    InwellUsers(
                      image: AssetHelper.bang_thanh_tich,
                      label: 'Bảng thành \n tích',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => AchievementChartScreen()));
                      },
                    ),
                    InwellUsers(
                      image: AssetHelper.bang_nho_hang_tuan,
                      label: 'Tạo lập\n lịch trình',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScheleduScreen()));
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          'Sáng tối 🌗',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        trailing: ChangeThemeButtonWidget(),
                      ),
                    ),
                    InwellUsers(
                      image: AssetHelper.logout_icon_removebg_preview,
                      label: 'Đăng xuất',
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          )));
        });
  }
}

Future<users_model.User?> readUser() async {
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
  final snapshot = await docUser.get();
  return users_model.User.fromJson(snapshot.data()!);
}
