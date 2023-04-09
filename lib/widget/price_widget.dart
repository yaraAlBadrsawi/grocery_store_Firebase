import 'package:flutter/material.dart';
import 'package:grocery_store/widget/text_widget.dart';

class PriceWidget extends StatelessWidget {
  PriceWidget(this.salePrice, this.price, this.textPrice, this.isOnSale,
      {Key? key})
      : super(key: key);

  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;
  @override
  Widget build(BuildContext context) {
    double userPrice = isOnSale ? salePrice : price;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            title: '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
            color: Colors.green,
            textSize: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Visibility(
            visible: isOnSale ? true : false,
            child: Text(
                '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough)),
          ),
        ],
      ),
    );
  }
}
