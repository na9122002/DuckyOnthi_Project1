import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travo_app_source/Scheledu/Main_Scheledu.dart';
import 'package:travo_app_source/chart/AchievementsChart.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/notUpdate.dart';
import 'package:travo_app_source/work_done/MainWorkDone.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  static String routeName = "UsersScreen";
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  dynamic items = ["", "", "", ""];
  _readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? action = prefs.getStringList('items');
    items = action!;
  }

  void initState() {
    _readData();
  }

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
    return FutureBuilder<User?>(
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
                            Text('Chào ${user?.TenDangNhap}',
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
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
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
                        child: Row(
                          children: [
                            Container(
                                height: 45,
                                child: Image.asset(AssetHelper.bai_da_lam)),
                            Text('Bài đã\n làm',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
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

                    InkWell(
                      child: Container(
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
                        child: Row(
                          children: [
                            Container(
                                height: 45,
                                child:
                                    Image.asset(AssetHelper.bang_thanh_tich)),
                            Text('Bảng thành \n tích',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AchievementChartScreen()));
                      },
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: const [
                    //       BoxShadow(
                    //         color: Colors.black,
                    //         offset: Offset(2, 2),
                    //         blurRadius: 10,
                    //       ),
                    //     ],
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //           height: 45,
                    //           child:
                    //               Image.asset(AssetHelper.cai_dat_nguoi_dung)),
                    //       TextButton(
                    //         child: Text('Cài đặt \nngười dùng',
                    //             style: TextStyle(
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Colors.black)),
                    //         onPressed: () {},
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      child: Container(
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
                        child: Row(
                          children: [
                            Container(
                                height: 45,
                                child: Image.asset(
                                    AssetHelper.bang_nho_hang_tuan)),
                            Text('Thiết lập thời\n khóa biểu',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScheleduScreen()));
                      },
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: const [
                    //       BoxShadow(
                    //         color: Colors.black,
                    //         offset: Offset(2, 2),
                    //         blurRadius: 10,
                    //       ),
                    //     ],
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //           height: 45,
                    //           child: Image.asset(AssetHelper.thong_bao)),
                    //       TextButton(
                    //         child: Text('Thông báo',
                    //             style: TextStyle(
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Colors.black)),
                    //         onPressed: () {},
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      child: Container(
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
                        child: Row(
                          children: [
                            Container(
                                height: 45,
                                child: Image.asset(AssetHelper.goi_y)),
                            Text('Gợi ý',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Container(
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
                        child: Row(
                          children: [
                            Container(
                                height: 45,
                                child: Image.asset(
                                    AssetHelper.logout_icon_removebg_preview)),
                            Text('Đăng xuất',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
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
// Stream<List<User>> readUsers() => FirebaseFirestore.instance
//     .collection('users')
//     .snapshots()
//     .map((snapshot) =>
//         snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

Future<User?> readUser() async {
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
  return User.fromJson(snapshot.data()!);
}

class User {
  String id;
  final String TenDangNhap;
  final String Sodienthoai;
  final String email;
  final String MatKhau;
  User({
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
  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      TenDangNhap: json['TenDangNhap'],
      Sodienthoai: json['Sodienthoai'],
      email: json['email'],
      MatKhau: json['Matkhau']);
}










// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travo_app_source/LightAndDark.dart/theme_provider.dart';
// import 'package:travo_app_source/notUpdate.dart';

// class SettingScreen extends StatefulWidget {
//   const SettingScreen({Key? key}) : super(key: key);
//   static String routeName = "SettingScreen";
//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }

// class _SettingScreenState extends State<SettingScreen> {
//   bool light1 = true;
//   bool light2 = true;
//   _notUpDate(String function) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => OthersubjectScreen(
//                   subject: function,
//                 )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
//         ? 'DarkTheme'
//         : 'LightTheme';
//     return Scaffold(
//         body: SingleChildScrollView(
//             child: Column(
//       children: [
//         SizedBox(
//           height: 30,
//         ),
//         Text(
//           'Cài đặt người dùng',
//           style: TextStyle(fontSize: 30),
//         ),
//         Container(
//           height: 500,
//           child: GridView(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black,
//                       offset: Offset(2, 2),
//                       blurRadius: 10,
//                     ),
//                   ],
//                 ),
//               ),
//                Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black,
//                       offset: Offset(2, 2),
//                       blurRadius: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     )));
//   }
// }
