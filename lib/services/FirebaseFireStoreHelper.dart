import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_model.dart';
import '../model/users_model.dart';

class FirebaseFireStoreHelper {
  FirebaseFireStoreHelper._();
  static FirebaseFireStoreHelper fireStoreHelper = FirebaseFireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userCollection = "Users";
  final String productCollection = 'Product';

  Future SaveUserData(Users users, String id) async {
    print('user from firestore $users');
    await firestore.collection(userCollection).doc(id).set({
      "id": id,
      "email": users.email,
      "name": users.name,
    });
  }

  Future saveProduct(Product product) async {
    // print('save product');
    // await firestore.collection(productCollection)
    //     .add(product.toJson()).then((DocumentReference doc) =>
    //     print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
