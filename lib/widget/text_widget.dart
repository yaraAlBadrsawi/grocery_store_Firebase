import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final double? textSize;
  final bool? isTitle;
  final int? maxLine;

  const TextWidget({
    required this.title,
    this.isTitle = false,
    this.color = Colors.black,
    this.textSize = 16,
    this.maxLine = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontSize: textSize,
          fontWeight: isTitle! ? FontWeight.bold : FontWeight.normal),
    );
  }
}
