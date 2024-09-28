import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';
import 'package:travo_app_source/screens/intro/item_intro_widget.dart';
import 'package:travo_app_source/screens/representation/bottom_navigation_bar.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
  static String routeName = "inrtro_Screen";
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  final StreamController<int> _streamController = StreamController<int>();
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _streamController.add(_pageController.page!.toInt());
    });
  }

  final List<Widget> listPage = [
    ItemIntroWidget(
      title: '',
      description:
          '“Học vấn do người siêng năng đạt được, tài sản do người tinh tế sở hữu, quyền lợi do người dũng cảm nắm giữ, thiên đường do người lương thiện xây dựng.” – Franklin',
      sourceImage: AssetHelper.intro1,
      aligment: Alignment.centerRight,
    ),
    ItemIntroWidget(
      title: '',
      description:
          '“Học tập là hạt giống của kiến thức, kiến thức là hạt giống của hạnh phúc.” Ngạn ngữ Gruzia.',
      sourceImage: AssetHelper.intro2,
      aligment: Alignment.center,
    ),
    ItemIntroWidget(
      title: 'Chúc bạn thành công trong cuộc sống',
      description: '',
      sourceImage: AssetHelper.intro3,
      aligment: Alignment.centerLeft,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: listPage,
          ),
          ListView(
            children: [
              Positioned(
                left: 24,
                right: 24,
                bottom: 24 * 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: Color.fromRGBO(255, 189, 189, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_pageController.page == 2) {
                          Navigator.of(context).pushNamed(HomePage.routeName);
                        } else {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 189, 189, 1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24 * 2, vertical: 16),
                        child: StreamBuilder<int>(
                          initialData: 0,
                          stream: _streamController.stream,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data != 2 ? 'Tiếp' : 'Bắt đầu',
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
