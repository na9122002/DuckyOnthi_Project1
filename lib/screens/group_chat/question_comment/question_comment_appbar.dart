import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class QuestionCommentAppbar extends StatelessWidget implements PreferredSizeWidget{
  const QuestionCommentAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return AppBar(
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
      );
  }
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}