import 'package:flutter/material.dart';
import 'package:grocery_store/widget/text_widget.dart';
import 'package:iconly/iconly.dart';

class ListTileWidget extends StatelessWidget {
  TextWidget title;
  IconData icon;
  Function() onPressed;
  String? subtitle;

  ListTileWidget(
    this.title,
    this.icon,
    this.onPressed, {
    key,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrow_right_2),
      onTap: onPressed,
    );
  }
}
