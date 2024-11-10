import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';

class InwellUsers extends StatefulWidget {
  final dynamic image;
  final dynamic label;
  final VoidCallback onTap;
  const InwellUsers({Key? key,required this.image,required this.label,required this.onTap}) : super(key: key);
  
  @override
  State<InwellUsers> createState() => _InwellUsersState();
}

class _InwellUsersState extends State<InwellUsers> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                                height: 45,
                                child:
                                    Image.asset(widget.image)),
                            Text(widget.label,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      onTap: widget.onTap,
                    );
  }
}