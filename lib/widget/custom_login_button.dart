import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travo_app_source/screens/representation/bottom_navigation_bar.dart';

class CustomLoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const CustomLoginButton({Key? key,required this.label,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    TextButton(
                onPressed: onPressed,
                child: Container(
                  width: 140,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 6, 5, 5)),
                      left: BorderSide(
                          width: 1, color: Color.fromARGB(255, 10, 10, 10)),
                      right: BorderSide(width: 1, color: Color(0xFFFF000000)),
                      bottom: BorderSide(width: 1, color: Color(0xFFFF000000)),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(label,
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                ));
  }
}
