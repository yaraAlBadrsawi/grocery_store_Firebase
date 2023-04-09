import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/admin/product_list_screen.dart';

import '../constants.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = "/dashBoardScreen";

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  CollectionReference userSnapshot =
      FirebaseFirestore.instance.collection("User");

  CollectionReference categorySnapshot =
      FirebaseFirestore.instance.collection("Categories");

  CollectionReference productSnapshot =
      FirebaseFirestore.instance.collection("Products");

  CollectionReference offerSnapshot =
      FirebaseFirestore.instance.collection("Offers");

  CollectionReference orderSnapshot =
      FirebaseFirestore.instance.collection("Orders");

  CollectionReference revenueSnapshot =
      FirebaseFirestore.instance.collection("Revenue");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffee5da),
      body: Column(
        children: [
          ListTile(
            subtitle: StreamBuilder(
              stream: revenueSnapshot.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final revenue = snapshot.data?.docs.length;
                var totalRevenue;

                if (revenue == 1) {
                  totalRevenue = snapshot.data?.docs[0];
                }
                return revenue == 1
                    ? Text("\u{20B9} ${totalRevenue.data()["revenue"]}",
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 30.0, color: mainColor))
                    : const Center(child: Text("No Orders Sold"));
              },
            ),
            title: const Text(
              'Revenue',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.grey),
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                SizedBox(
                  height: 160,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    onPressed: () {},
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.people_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Users",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          StreamBuilder(
                            stream: userSnapshot
                                .where("userType", isEqualTo: 0)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              final user = snapshot.data?.docs;

                              return Text(
                                user!.length.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: mainColor, fontSize: 60.0),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  onPressed: () {},
                  child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.category),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Category',
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ],
                        ),
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: categorySnapshot
                              .doc('Categories')
                              .snapshots()
                              .map((DocumentSnapshot<Object?> snapshot) =>
                                  snapshot
                                      as DocumentSnapshot<Map<String, dynamic>>)
                              .asBroadcastStream(),
                          // categorySnapshot.doc("Categories").snapshots(),

                          builder: (context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final category = snapshot.data?.data()?.keys.length;

                            return Text(
                              category.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: mainColor, fontSize: 60.0),
                            );
                          },
                        ),
                      ],
                      // title: ElevatedButton.icon(
                      //     onPressed: null,
                      //     icon: const Icon(Icons.category),
                      //     label: const Text("Category")),
                    ),
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ProductListScreen.routeName);
                    },
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.track_changes),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Products",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          StreamBuilder(
                            stream: offerSnapshot.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              final offers = snapshot.data!.docs;

                              return Text(
                                offers.length.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: mainColor, fontSize: 60.0),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    onPressed: () {},
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.local_offer),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Offers",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          StreamBuilder(
                            stream: offerSnapshot.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              final offers = snapshot.data!.docs;

                              return Text(
                                offers.length.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: mainColor, fontSize: 60.0),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.shopping_cart),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Orders',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                          StreamBuilder(
                              stream: orderSnapshot
                                  .orderBy(
                                    "fulFilled",
                                  )
                                  .orderBy("orderDate")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                final orders = snapshot.data?.docs;

                                return ListTile(
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(
                                    //   OrderListScreen.routeName,
                                    // );
                                  },
                                  title: ElevatedButton.icon(
                                      onPressed: null,
                                      icon: const Icon(Icons.shopping_cart),
                                      label: const Text("Orders")),
                                  subtitle: Text(
                                    orders!.length.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: mainColor, fontSize: 60.0),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 160,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.tag_faces),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sold",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          StreamBuilder(
                            stream: orderSnapshot
                                .where("fulFilled", isEqualTo: 1)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              final orders = snapshot.data?.docs;
                              return Text(
                                orders!.length.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: mainColor, fontSize: 60.0),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
