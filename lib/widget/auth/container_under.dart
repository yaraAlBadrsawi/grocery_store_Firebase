import 'package:flutter/material.dart';

import '../text_widget.dart';

class ContainerUnder extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final String textType;
  final Color? color;

  const ContainerUnder(
      {required this.text,
      required this.onPressed,
      required this.textType,
      Key? key,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            textSize: 20,
            isTitle: true,
            title: text,
            color: Colors.white,
          ),
          TextButton(
            onPressed: onPressed,
            child: TextWidget(
              textSize: 20,
              isTitle: true,
              title: textType,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
