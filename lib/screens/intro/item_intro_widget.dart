import 'package:flutter/material.dart';
import 'package:travo_app_source/helpers/image_helper.dart';

class ItemIntroWidget extends StatelessWidget {
  const ItemIntroWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.sourceImage,
    required this.aligment,
  }) : super(key: key);

  final String title;
  final String description;
  final String sourceImage;
  final AlignmentGeometry aligment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: aligment,
          child: ImageHelper.loadFromAsset(
            sourceImage,
            height: 400,
            fit: BoxFit.fitHeight,
          ),
        ),
        SizedBox(
          height: 24 * 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                description,
              ),
            ],
          ),
        )
      ],
    );
  }
}
