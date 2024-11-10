import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/group_chat/creat_question/creat_question.dart';
import 'package:travo_app_source/screens/group_chat/history_chat/history_chat.dart';

class MainGroupChatAppbar extends StatelessWidget implements PreferredSizeWidget{
  final dynamic UserName;
  const MainGroupChatAppbar({Key? key,required this.UserName }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return AppBar(
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              Container(
                  width: width / 2,
                  child: InkWell(
                    child: Image.asset(AssetHelper.Viet_bai),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatQuestionScreen(
                                    UserName: UserName,
                                  )));
                    },
                  )),
              Container(
                  width: width / 2,
                  child: InkWell(
                    child: Image.asset(AssetHelper.Lich_su),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryChatSceen()));
                    },
                  )),
            ],
          )
        ],
      );
  }
Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}