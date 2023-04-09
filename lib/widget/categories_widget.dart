import 'package:flutter/material.dart';
import 'package:grocery_store/widget/text_widget.dart';

class CategoriesWidget extends StatelessWidget {
  final String image;
  final String category;
  final Color color;

  const CategoriesWidget(this.image, this.category, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.7),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: _screenWidth * 0.3,
            width: _screenWidth * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          TextWidget(
            title: category,
            color: Colors.black,
            isTitle: true,
            textSize: 20,
          )
        ],
      ),
    );
  }
}
