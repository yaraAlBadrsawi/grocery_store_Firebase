import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/admin/add_product_screen.dart';
import 'package:grocery_store/admin/dashBoard_screen.dart';
import 'package:grocery_store/model/product_model.dart';
import 'package:grocery_store/screens/add_product.dart';
import 'package:grocery_store/screens/cart/cart.dart';
import 'package:grocery_store/screens/home_screen.dart';
import 'package:grocery_store/screens/launch_screen.dart';

import 'admin/product_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.routeName: (_) => const WelcomeScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        CartScreen.routeName: (_) => CartScreen(),
        DashBoardScreen.routeName: (_) => DashBoardScreen(),
        ProductListScreen.routeName: (_) => ProductListScreen(),
        AddProductScreen.routeName: (_) => AddProductScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
