import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  final dynamic choose;
  final dynamic listAnswer;
  final dynamic color;
  final int index;
  final Function(String?) onChanged;
  final int i;
  final TextStyle styleAnswer;
  const Answer(
      {Key? key,
      required this.choose,
      required this.listAnswer,
      required this.color,
      required this.index,
      required this.styleAnswer,
      required this.onChanged,
      required this.i})
      : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 189, 189, 1),
        borderRadius: BorderRadius.circular(45),
      ),
      child: RadioListTile<String>(
        activeColor: Colors.black,
        groupValue: widget.choose[widget.index],
        value: '${widget.listAnswer[widget.index][widget.i]}',
        title: Text(
          '${widget.listAnswer[widget.index][widget.i]}',
          style: widget.styleAnswer,
        ),
        onChanged: widget.onChanged,
      ),
    );

    // Updates the color of the selected answer option
  }
}
