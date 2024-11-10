import 'package:flutter/material.dart';

class QuestionApiAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final DateTime startTime;

  const QuestionApiAppbar({
    Key? key,
    required this.onPressed,
    required this.startTime
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.black,
      title: const Text(
        'Đề Thi',
        style: TextStyle(fontSize: 30, color: Colors.black),
      ),
      backgroundColor: Color.fromRGBO(255, 189, 189, 1),
      actions: [
        TextButton(
          child: const Text(
            'Nộp bài',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          onPressed: onPressed
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
