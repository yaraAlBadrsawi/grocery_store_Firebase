import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_store/widget/price_widget.dart';
import 'package:grocery_store/widget/text_widget.dart';

import 'heart_btn.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({Key? key}) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // get data from firebase
    return Material(
      color: Colors.blueGrey.withOpacity(0.2),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Image.asset(
              "assets/images/apple.png",
              width: size.width * 0.10,
              height: size.height * 0.10,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  TextWidget(
                    title: 'title',
                    textSize: 20,
                    color: Colors.black,
                  ),
                  HeartBtn(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceWidget(
                    2.99,
                    5.9,
                    _controller.text,
                    true,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        const FittedBox(
                          child: TextWidget(
                            title: "KG",
                            textSize: 16,
                            isTitle: true,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _controller,
                            key: const ValueKey('10'),
                            keyboardType: TextInputType.number,
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9.]'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const TextWidget(
                  title: 'Add to cart',
                  maxLine: 1,
                  color: Colors.black,
                  textSize: 20,
                ),
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
