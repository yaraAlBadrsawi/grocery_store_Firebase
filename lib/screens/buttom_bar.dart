import 'package:flutter/material.dart';
import 'package:grocery_store/screens/user.dart';
import 'package:iconly/iconly.dart';
import 'cart/cart.dart';
import 'categories.dart';
import 'home_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _pages = [
      {'page': HomeScreen(), 'title': 'Home Screen'},
      {'page': CategoriesScreen(), 'title': 'Categories Screen'},
      {'page': CartScreen(), 'title': 'Cart Screen'},
      {'page': UserScreen(), 'title': 'User Screen'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('${_pages[_selectedIndex]['title']}'),
      ),
      body: _pages[_selectedIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? IconlyBold.category : IconlyLight.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? IconlyBold.user_2 : IconlyLight.user,
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
