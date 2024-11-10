import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';

class QuestionApiBottom extends StatelessWidget {
  final height;
  final width;
  final pageController;
  const QuestionApiBottom({Key? key,required this.height,required this.width,required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Container(
      height: height / 10.1,
      color: Colors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: width / 5.1),
                    child: Image.asset(AssetHelper.imagemuiten),
                    height: 60,
                    width: 60,
                  ),
                  onTap: () {

                  pageController.previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  }),
              InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: width / 5.1),
                    child: Image.asset(AssetHelper.imagemuiten2),
                    height: 60,
                    width: 60,
                  ),
                  onTap: () {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
