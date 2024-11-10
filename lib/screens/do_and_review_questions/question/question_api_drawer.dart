import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
    required this.models,
    required this.color,
    required this.pageController,
    required this.choose,
    required this.listAnswer,
  }) : super(key: key);

  final List<dynamic> models;
  final List<List<Color?>> color;
  final PageController pageController;
  final List<String?> choose;
  final List<List<String?>> listAnswer;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // This method builds an individual option button
  Widget buildOptionButton(int questionIndex, int optionIndex, String label) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        color: widget.color[questionIndex][optionIndex],
        borderRadius: BorderRadius.circular(90),
      ),
      child: TextButton(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () {
          setState(() {
            // Update the selected answer and colors
            widget.choose[questionIndex] = widget.listAnswer[questionIndex][optionIndex];
            for (int i = 0; i < widget.color[questionIndex].length; i++) {
              widget.color[questionIndex][i] = (i == optionIndex)
                  ? const Color.fromRGBO(255, 189, 189, 1)
                  : Colors.white;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          children: [
            for (int i = 0; i < widget.models.length; i++)
              Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    TextButton(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        widget.pageController.jumpToPage(i);
                      },
                    ),
                    buildOptionButton(i, 0, 'A'),
                    buildOptionButton(i, 1, 'B'),
                    buildOptionButton(i, 2, 'C'),
                    buildOptionButton(i, 3, 'D'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
