import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:toast/toast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/product_model.dart';
import '../model/product_text_controllers.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = "/add_product_screen";
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<Asset> images = [];
  final _form = GlobalKey<FormState>();
  List<String> imageUrls = <String>[]; // product images
  List<String> sp = []; // unit1
  List<String> mrp = []; //unit2
  List<String> productSize = []; // product Size
  FirebaseFirestore db = FirebaseFirestore.instance;
  var isLoading = false;
  var brandEditingController = TextEditingController();
  var productNameEditingController = TextEditingController();
  var variantEditingController = TextEditingController();
  var mrpEditingController = TextEditingController();
  var spEditingController = TextEditingController();
  var sizeEditingController = TextEditingController();
  var brandFocusNode = FocusNode();
  var productNameFocusNode = FocusNode();
  var variantFocusNode = FocusNode();
  var categoryFocusNode = FocusNode();
  var unitFocusNode = FocusNode();
  var mrpFocusNode = FocusNode();
  var spFocusNode = FocusNode();
  var sizeFocusNode = FocusNode();
  List<String> categories = ['test1', 'test2', 'test3'];
  String? _selectedCategory;
  List<String> units = ["grams", "litre", "kg", "packets"];
  String? _selectedUnit;
  final List<ProductTextControllers> productTextControllers =
      <ProductTextControllers>[];
  XFile? imagefile;

  @override
  void initState() {
    productTextControllers.add(ProductTextControllers(TextEditingController(),
        TextEditingController(), TextEditingController()));
    Future.delayed(Duration.zero).then((value) {
      final value =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final edit = value["edit"];
      if (edit == 1) {
        final QueryDocumentSnapshot product = value["product"];
        print(product["brand"]);
        brandEditingController.text = product["brand"];
        productNameEditingController.text = product["productName"];
        variantEditingController.text = product["variant"];
        _selectedCategory = product["category"];
        _selectedUnit = product["unit"];
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    brandEditingController.clear();
    productNameEditingController.clear();
    variantEditingController.clear();
    mrpEditingController.clear();
    spEditingController.clear();
    sizeEditingController.clear();
    brandFocusNode.dispose();
    productNameFocusNode.dispose();
    variantFocusNode.dispose();
    categoryFocusNode.dispose();
    unitFocusNode.dispose();
    mrpFocusNode.dispose();
    spFocusNode.dispose();
    sizeFocusNode.dispose();
    super.dispose();
  }

  DocumentSnapshot? cat;

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      FirebaseFirestore.instance
          .collection("Categories")
          .doc("Categories")
          .get()
          .then((value) {
        final cate = value.data();

        for (var data in cate!.keys.toList()) {
          categories.add(data);
        }
        categories.sort();
        setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    // final value =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //
    // final edit = value["edit"];

    if (isValid) {
      if (images.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        _form.currentState!.save();
        await uploadImages();
        try {
          // if (edit == 1) {
          //   final id = value["id"];
          //   await Product().updateProduct(
          //       id,
          //       Product(
          //           category: _selectedCategory,
          //           brand: brandEditingController.text,
          //           productName: productNameEditingController.text,
          //           variant: variantEditingController.text,
          //           unit: _selectedUnit,
          //           imageUrl: imageUrls,
          //           mrp: mrp,
          //           sellingPrice: sp,
          //           size: productSize));
          // } else {
          await Product().addProduct(Product(
              category: _selectedCategory,
              brand: brandEditingController.text,
              productName: productNameEditingController.text,
              variant: variantEditingController.text,
              unit: _selectedUnit,
              imageUrl: imageUrls,
              mrp: mrp,
              sellingPrice: sp,
              size: productSize));
          // }
          Navigator.of(context).pop();
        } catch (e) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("An error occurred!"),
              content: Text("Something Went Wrong!!"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Okay"),
                )
              ],
            ),
          );
        }
        setState(() {
          isLoading = false;
        });
      } else {
        Toast.show(
          'Please add some photos',
          textStyle: context,
        );
      }
    }
  }

  Future<Future> _onBackPressed() async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Do you want to exit"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("NO"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text("yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 200,
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Your product is being uploaded..Please wait.")
                  ],
                ),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          //width: 110,
                          padding: EdgeInsets.only(top: 11),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: "Select Category*",
                            ),
                            items: categories
                                .map(
                                  (value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ),
                                )
                                .toList(),
                            onChanged: (category) {
                              setState(() {
                                _selectedCategory = category!;
                              });
                            },
                            value: _selectedCategory,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "select something";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            controller: brandEditingController,
                            decoration: const InputDecoration(
                                hintText: "Enter Brand Name",
                                labelText: "Brand Name"),
                            focusNode: brandFocusNode,
                            onFieldSubmitted: (value) {
                              productNameFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.trim().length == 0) {
                                return "Type something";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            controller: productNameEditingController,
                            decoration: InputDecoration(
                                hintText: "Enter Product Name",
                                labelText: "Product Name"),
                            focusNode: productNameFocusNode,
                            onFieldSubmitted: (value) {
                              variantFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.trim().length == 0) {
                                return "Type something";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            controller: variantEditingController,
                            decoration: InputDecoration(
                                hintText: "Enter Variant",
                                labelText: "Variant"),
                            focusNode: variantFocusNode,
                            onFieldSubmitted: (value) {
                              unitFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.trim().length == 0) {
                                return "Type something";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          //width: 110,
                          padding: EdgeInsets.only(top: 11),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: "Select Unit*",
                            ),
                            items: units
                                .map(
                                  (value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ),
                                )
                                .toList(),
                            onChanged: (unit) {
                              _selectedUnit = unit!;
                            },
                            value: _selectedUnit,
                            validator: (value) {
                              if (value!.trim().length == 0) {
                                return "select something";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width * 3 / 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: loadAssets,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColor),
                                child: const Text("Pick image"),
                              ),
                              Expanded(
                                child: buildGridView(),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          //width: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...productTextControllers.map(
                                  (personController) =>
                                      buildCard(personController)),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FloatingActionButton(
                                      heroTag: 1,
                                      child: const Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          productTextControllers
                                              .add(ProductTextControllers(
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                          ));
                                        });
                                      }),
                                  FloatingActionButton(
                                      heroTag: 2,
                                      child: Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          productTextControllers.removeLast();
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isLoading
          ? null
          : FloatingActionButton(
              backgroundColor: mainColor,
              onPressed: () {
                if (!isLoading) _saveForm();
              },
              child: const Icon(Icons.save),
            ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            Container(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return images.isEmpty
        ? GestureDetector(
            onTap: () => loadAssets(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    width: images.length == 0 ? 2 : 0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Icon(Icons.add),
              ),
            ),
          )
        : GridView.count(
            crossAxisCount: 3,
            children: List.generate(images.length, (index) {
              Asset asset = images[index];
              return AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              );
            }),
          );
  }

  Future<void> loadAssets() async {
    // _requestPermission();
    // print('_requestPermission ===== ${_requestPermission()}');
    // print('_checkPermission ===== ${_checkPermission()}');if (await _checkPermission()) {
    List<Asset> resultList = [];
    String error = 'No Error Dectected';

    try {
      _requestPermission();
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarTitle: "Choose photos",
          allViewTitle: "All Photos",
          actionBarColor: "#f4a261",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future<void> uploadImages() async {
    for (var imageFile in images) {
      await postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          return;
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage db = FirebaseStorage.instance;
    await db
        .ref()
        .child("images")
        .child("$fileName")
        .putData((await imageFile.getByteData()).buffer.asUint8List());
    return db.ref().child("images").child("$fileName").getDownloadURL();
  }

  // Requesting runtime permissions
  Future<void> _requestPermission() async {
    var storageStatus = await Permission.storage.status;
    if (storageStatus.isGranted) {
      // Permission already granted
      return;
    }
    if (storageStatus.isDenied) {
      // Permission already denied
      return;
    }
    await Permission.storage.request();
  }

  // Checking if permission is granted
  Future<bool> _checkPermission() async {
    var storageStatus = await Permission.storage.status;
    return storageStatus == PermissionStatus.granted;
  }

  Widget buildCard(ProductTextControllers controllers) {
    return Row(
      children: [
        _buildMrpField(controllers.mrp),
        const SizedBox(width: 10.0),
        _buildSpField(controllers.sp),
        const SizedBox(width: 10.0),
        _buildSizeField(controllers.size),
        const SizedBox(width: 10.0),
      ],
    );
  }

  _buildMrpField(TextEditingController mrps) {
    return Container(
      width: 100,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: mrps,
        decoration: InputDecoration(hintText: "Enter MRP", labelText: "MRP"),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.trim().length == 0) {
            return "Type something";
          }
          return null;
        },
        onFieldSubmitted: (value) {
          setState(() {
            mrp.add(mrps.text);
          });
        },
      ),
    );
  }

  _buildSpField(TextEditingController sps) {
    return Container(
      width: 100,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: sps,
        decoration: InputDecoration(hintText: "Enter SP", labelText: "SP"),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.trim().length == 0) {
            return "Type something";
          }
          return null;
        },
        onFieldSubmitted: (value) {
          setState(() {
            sp.add(sps.text);
          });
        },
      ),
    );
  }

  _buildSizeField(TextEditingController sizes) {
    return Container(
      width: 100,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: sizes,
        decoration: InputDecoration(hintText: "Enter Size", labelText: "Size"),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.trim().length == 0) {
            return "Type something";
          }
          return null;
        },
        onFieldSubmitted: (value) {
          setState(() {
            productSize.add(sizes.text);
          });
        },
      ),
    );
  }
}
