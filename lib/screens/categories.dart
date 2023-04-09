import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/widget/categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
  List<Map<String, dynamic>> categories = [
    {
      'categoriesName': 'Vegetables',
      'categoriesImage': 'assets/images/vegetables.png'
    },
    {'categoriesName': 'Fruits', 'categoriesImage': 'assets/images/fruits.png'},
    {'categoriesName': 'Herbs', 'categoriesImage': 'assets/images/herbs.png'},
    {'categoriesName': 'Nuts', 'categoriesImage': 'assets/images/nuts.png'},
    {'categoriesName': 'Spices', 'categoriesImage': 'assets/images/spices.png'},
    {'categoriesName': 'Grain', 'categoriesImage': 'assets/images/grains.png'},
  ];

  List gridColors = [
    const Color(0xe8e95d5d),
    const Color(0xff2990d9),
    const Color(0xff55df47),
    const Color(0xffe458d2),
    const Color(0xffd8a75e),
    const Color(0xff676eab),
  ];

  // const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 250,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
              categories.length,
              (index) => CategoriesWidget(categories[index]['categoriesImage'],
                  categories[index]['categoriesName'], gridColors[index]),
            ),
          ),
        ),
      ),
    );
  }
}
