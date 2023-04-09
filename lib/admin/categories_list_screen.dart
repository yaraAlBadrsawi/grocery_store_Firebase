import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/constants.dart';

import 'add_categories.dart';
import 'add_product_screen.dart';

class CategoriesListScreen extends StatefulWidget {
  static const routeName = "/product_list_screen";
  @override
  _CategoriesListScreenState createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  CollectionReference categoriesSnapshot =
      FirebaseFirestore.instance.collection("Categories");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        elevation: 10,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddCategoriesScreen.routeName);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: const Text("Categories List"),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )),
      ),
      body: Stack(
        children: [
          StreamBuilder(
              stream: categoriesSnapshot.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final categories = snapshot.data!.docs;

                return categories.isNotEmpty
                    ? ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              Navigator.of(context).pushNamed(
                                  AddCategoriesScreen.routeName,
                                  arguments: {
                                    "id": categories[index].id,
                                    "product": categories[index],
                                    "edit": 1
                                  });
                            },
                            onTap: () async {
                              // await ProductModel().deleteProduct(
                              //   id: products[index].id,
                              // );
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      categories[index]['imageUrls'][0]),
                                  radius: 20,
                                ),
                                title: Text(categories[index]['brand']),
                                subtitle:
                                    Text(categories[index]['productName']),
                                trailing: Text(categories[index]['category']),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text("Add products"),
                      );
              }),
          // Positioned(
          //   bottom: 15,
          //   right: 15,
          //   child: FloatingActionButton(
          //     backgroundColor: mainColor,
          //     elevation: 10,
          //     child: Icon(Icons.add),
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(AddProductScreen.routeName,
          //           arguments: {"edit": 0});
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
