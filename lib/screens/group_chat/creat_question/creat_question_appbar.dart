import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';

class CreatQuestionAppbar extends StatelessWidget implements PreferredSizeWidget{
  const CreatQuestionAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return  AppBar(
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
      );
  }
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}