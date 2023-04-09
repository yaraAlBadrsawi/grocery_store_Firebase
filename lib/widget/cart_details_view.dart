// import 'package:flutter/material.dart';
//
// class CartDetailsView extends StatelessWidget {
//   const CartDetailsView({Key? key, required this.controller}) : super(key: key);
//
//   final HomeController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Cart", style: Theme.of(context).textTheme.headline6),
//           ...List.generate(
//             controller.cart.length,
//             (index) => CartDetailsViewCard(productItem: controller.cart[index]),
//           ),
//           SizedBox(height: 50),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {},
//               child: Text("Next - \$30"),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
