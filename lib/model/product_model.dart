import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? category;
  String? brand;
  String? productName;
  List<String>? imageUrl;
  String? variant;
  String? unit;
  List<String>? sellingPrice;
  List<String>? mrp;
  List<String>? size;

  Product({
    this.category,
    this.brand,
    this.productName,
    this.imageUrl,
    this.variant,
    this.unit,
    this.sellingPrice,
    this.mrp,
    this.size,
  });

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    Map<String, dynamic> data = {
      'category': product.category,
      'brand': product.brand,
      'productName': product.productName,
      'imageUrls': product.imageUrl,
      'variant': product.variant,
      'mrp': product.mrp,
      'sellingPrice': product.sellingPrice,
      'size': product.size,
      'unit': product.unit,
    };
    await db
        .collection("Products")
        .add(data)
        .then((value) => print('product added done'));
  }

  Future<void> updateProduct(String id, Product editedProduct) async {
    Map<String, dynamic> data = {
      'category': editedProduct.category,
      'brand': editedProduct.brand,
      'productName': editedProduct.productName,
      'imageUrls': editedProduct.imageUrl,
      'variant': editedProduct.variant,
      'mrp': editedProduct.mrp,
      'sellingPrice': editedProduct.sellingPrice,
      'size': editedProduct.size,
      'unit': editedProduct.unit,
    };

    await db.collection("Products").doc(id).update(data);
  }

  Future<void> deleteProduct(String id) async {
    await db.collection("Products").doc(id).delete();
  }

  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> data = Map();
  //   data['product id'] = this.productId;
  //   data['product name'] = this.productName;
  //   data['product price'] = this.productPrice;
  //   data['product image'] = this.productImage;
  //   data['product Category'] = this.productCategory;
  //   return data;
  // }

  // Product.fromJson(Map<String, dynamic> data) {
  //   productId = data['product id'];
  //   productName = data['product name'];
  //   productPrice = data['product price'];
  //   productImage = data['product image'];
  //   productCategory = data['product Category'];
  // }
}
