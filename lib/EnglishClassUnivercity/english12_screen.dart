import 'package:flutter/material.dart';
import 'package:travo_app_source/Question/Question_model_normal.dart';
import 'package:travo_app_source/EnglishClassUnivercity/list_question_english.dart';

class English12Screen extends StatefulWidget {
  const English12Screen({Key? key}) : super(key: key);
  static const routeName = 'english12_screen';
  @override
  State<English12Screen> createState() => _English12ScreenState();
}

_Ontap(dynamic topic, dynamic context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              QuesionNormalModel(topic: topic, subject: 'Tiếng Anh')));
}

class _English12ScreenState extends State<English12Screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text(
            'Tiếng Anh THPT quốc gia',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(255, 189, 189, 1),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'Ngữ pháp',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Từ vựng',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Đề thi',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Column(
              children: [
                ListTile(
                    title: Text(
                      'Đề 1',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(topic1, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 2',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(topic2, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 3',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(topic3, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 4',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(topic4, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 5',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(topic5, context);
                    }),
              ],
            ),
            Column(
              children: [
                ListTile(
                    title: Text(
                      'Đề 1',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(toppicVC1, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 2',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(toppicVC2, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 3',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(toppicVC3, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 4',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(toppicVC4, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 5',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(toppicVC5, context);
                    }),
              ],
            ),
            Column(
              children: [
                ListTile(
                    title: Text(
                      'Đề 1',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(TopicDH1, context);
                    }),
                ListTile(
                    title: Text(
                      'Đề 2',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      _Ontap(TopicDH2, context);
                    }),
              ],
            )
          ],
        ),

        //  ListView(
        //   children: [
        //     Column(
        //       children: [
        //         ExpansionTile(
        //           title: Text(
        //             'Ngữ pháp',
        //             style: TextStyle(
        //               color: Colors.red,
        //             ),
        //           ),
        //           children: [
        //             ListTile(
        //                 title: Text(
        //                   'Đề 1',
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //                 onTap: () {
        //                   _Ontap(topic1, context);
        //                 }),
        //             ListTile(
        //                 title: Text(
        //                   'Đề 2',
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //                 onTap: () {
        //                   _Ontap(topic2, context);
        //                 }),
        //             ListTile(
        //                 title: Text(
        //                   'Đề 3',
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //                 onTap: () {
        //                   _Ontap(topic3, context);
        //                 }),
        //             ListTile(
        //                 title: Text(
        //                   'Đề 4',
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //                 onTap: () {
        //                   _Ontap(topic4, context);
        //                 }),
        //             ListTile(
        //                 title: Text(
        //                   'Đề 5',
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //                 onTap: () {
        //                   _Ontap(topic5, context);
        //                 }),
        //           ],
        //         ),
        //         Container(
        //           child: ExpansionTile(
        //             title: Text(
        //               'Từ Vựng',
        //               style: TextStyle(
        //                 color: Colors.red,
        //               ),
        //             ),
        //             children: [
        //               ListTile(
        //                   title: Text(
        //                     'Đề 1',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                   onTap: () {
        //                     _Ontap(toppicVC1, context);
        //                   }),
        //               ListTile(
        //                   title: Text(
        //                     'Đề 2',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                   onTap: () {
        //                     _Ontap(toppicVC2, context);
        //                   }),
        //               ListTile(
        //                   title: Text(
        //                     'Đề 3',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                   onTap: () {
        //                     _Ontap(toppicVC3, context);
        //                   }),
        //               ListTile(
        //                   title: Text(
        //                     'Đề 4',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                   onTap: () {
        //                     _Ontap(toppicVC4, context);
        //                   }),
        //               ListTile(
        //                   title: Text(
        //                     'Đề 5',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                   onTap: () {
        //                     _Ontap(toppicVC5, context);
        //                   }),
        //             ],
        //           ),
        //         ),
        //         Container(
        //           child: ExpansionTile(
        //             title: Text(
        //               'Đề Thi',
        //               style: TextStyle(
        //                 color: Colors.red,
        //               ),
        //             ),
        //             children: [
        //               ListTile(
        //                   title: Text(
        //                     'Đề 1',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                   onTap: () {
        //                     _Ontap(TopicDH1, context);
        //                   }),
        //               ListTile(
        //                   title: Text(
        //                     'Đề 2',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                   onTap: () {
        //                     _Ontap(TopicDH2, context);
        //                   }),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
