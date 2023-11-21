import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travo_app_source/Biology/List_biology12.dart';
import 'package:travo_app_source/Chemictry/List_Chemistry12.dart';
import 'package:travo_app_source/EnglishClass10/Screen_English_TS10.dart';
import 'package:travo_app_source/EnglishClassUnivercity/english12_screen.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/notUpdate.dart';

class AppBarContainerWidget extends StatefulWidget {
  const AppBarContainerWidget({Key? key}) : super(key: key);
  static const routeName = 'app_bar_container';
  @override
  State<AppBarContainerWidget> createState() => _AppBarContainerWidgetState();
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class _AppBarContainerWidgetState extends State<AppBarContainerWidget> {
  dynamic items = [];
  _readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('items') != null) {
      final List<String> action = prefs.getStringList('items')!;
      setState(() {
        items = action;
      });
    }
  }

  @override
  void initState() {
    _readData();
  }

  var size, height, width;
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  _floatbutton(String images, String subject, dynamic Height) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
            child: Container(
              width: Height / 7.76,
              height: Height / 7.76,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 189, 189, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 90,
                    ),
                    Container(
                      child: Image.asset(images),
                    ),
                    SizedBox(
                      height: height / 92,
                    ),
                    Text(
                      subject,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Colors.black,
                actions: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: const Text('Chọn chương trình học',
                            style: TextStyle(
                                color: Color.fromARGB(255, 249, 247, 247),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                            child: Container(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Ôn thi THPT Quốc Gia',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 189, 189, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 50,
                              width: 190,
                            ),
                            onTap: () {
                              if (subject == 'Tiếng Anh') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            English12Screen()));
                              } else if (subject == 'Hóa Học') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Chemistry12Screen()));
                              } else if (subject == 'Sinh Học') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Biology12Screen()));
                              }

                              // else if (subject == 'Toán') {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => Math10Screen()));
                              // }
                              else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OthersubjectScreen(
                                              subject: subject,
                                            )));
                              }
                            }),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Container(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Ôn thi tuyển sinh lớp 10',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            margin:
                                EdgeInsets.only(top: 16, right: 7, bottom: 33),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 189, 189, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 50,
                            width: 190,
                          ),
                          onTap: () => setState(() {
                            if (subject == 'Tiếng Anh') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => English10Screen()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OthersubjectScreen(
                                          subject: subject)));
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = [
    AssetHelper.carousel1,
    AssetHelper.carousel2,
    AssetHelper.carousel3,
    AssetHelper.carousel4,
  ];
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   height: height / 3.247,
          //   width: width,
          //   child: CarouselSlider(
          //     options: CarouselOptions(
          //       viewportFraction: 1,
          //       autoPlay: true,
          //       autoPlayInterval: Duration(seconds: 3),
          //       //enlargeCenterPage: true,
          //     ),
          //     items: [
          //       AssetHelper.carousel1,
          //       AssetHelper.carousel2,
          //       AssetHelper.carousel3,
          //       AssetHelper.carousel4,
          //     ].map((i) {
          //       return Builder(
          //         builder: (BuildContext context) {
          //           return Container(
          //             decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                     image: AssetImage(i), fit: BoxFit.fill)),
          //           );
          //         },
          //       );
          //     }).toList(),
          //   ),
          // ),
          CarouselSlider.builder(
              carouselController: controller,
              itemCount: urlImages.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage, index, width);
              },
              options: CarouselOptions(
                  height: height / 3.5,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index))),
          SizedBox(
            height: height / 186.4,
          ),
          buildIndicator(),
          SizedBox(
            height: height / 186.4,
          ),
          Container(
            height: height / 46.6,
            color: Color.fromRGBO(255, 189, 189, 1),
            child: Marquee(
              text: 'Chào mừng bạn đến với app học Ducky ôn thi',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 100.0,
              pauseAfterRound: Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 19, bottom: 34, right: 19, top: 33),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _floatbutton(AssetHelper.imageEnglish, 'Tiếng Anh', height),
                _floatbutton(AssetHelper.iconMath, 'Toán', height),
                _floatbutton(AssetHelper.imageLiterature, 'Ngữ Văn', height),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19, bottom: 34, right: 19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _floatbutton(AssetHelper.imagePhysics, 'Vật Lý', height),
                _floatbutton(AssetHelper.imageChemistry, 'Hóa Học', height),
                _floatbutton(AssetHelper.imageExercise, 'Sinh Học', height),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19, right: 19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _floatbutton(AssetHelper.imageHistory, 'Lịch Sử', height),
                _floatbutton(AssetHelper.imageGeographic, 'Địa Lý', height),
                _floatbutton(AssetHelper.imageComputer, 'Công Dân', height),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotWidth: 15, activeDotColor: Color.fromRGBO(255, 189, 189, 1)),
        activeIndex: activeIndex,
        count: urlImages.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index, dynamic width) =>
    // Container(child: Image.asset(urlImage),

    // )

    Container(
      width: width,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(urlImage), fit: BoxFit.fill)),
    );
