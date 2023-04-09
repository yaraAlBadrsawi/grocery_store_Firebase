import 'package:flutter/material.dart';
import 'package:grocery_store/widget/price_widget.dart';
import 'package:grocery_store/widget/text_widget.dart';
import 'package:iconly/iconly.dart';

import 'heart_btn.dart';

class OnSaleWidget extends StatelessWidget {
  const OnSaleWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      color: Colors.blue.withOpacity(0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/apple.png",
                    width: size.width * 0.12,
                    height: size.height * 0.12,
                  ),
                  Column(
                    children: [
                      const TextWidget(
                        title: '1KG',
                        color: Colors.black,
                        textSize: 20,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              IconlyLight.bag,
                              size: 22,
                            ),
                          ),
                          HeartBtn(),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              // PriceWidget(
              //   2.99,
              //   5.9,
              //   'any',
              //   true,
              // ),
              const SizedBox(
                height: 5,
              ),
              const TextWidget(
                title: "product title",
                isTitle: true,
                textSize: 16,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
