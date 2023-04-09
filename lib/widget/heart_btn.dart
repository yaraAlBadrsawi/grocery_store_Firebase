import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HeartBtn extends StatelessWidget {
  const HeartBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Icon(
        IconlyLight.heart,
        size: 20,
      ),
    );
  }
}
