// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:grocery_store/model/product_model.dart';
// import 'package:grocery_store/services/FirebaseFireStoreHelper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../constants.dart';
// import '../widget/auth/auth_text_from_field.dart';
//
// class AddProduct extends StatefulWidget {
//
//
//    AddProduct({Key? key}) : super(key: key);
//
//   @override
//   State<AddProduct> createState() => _AddProductState();
// }
//
// class _AddProductState extends State<AddProduct> {
//   final _formKey = GlobalKey<FormState>();
//   final _productNameController=TextEditingController();
//   final _productPriceController=TextEditingController();
//   // final _productImage
//
//
//
//   FirebaseStorage  storage =
//       FirebaseStorage.instance;
//
//   File? _image;
//   // final ImagePicker _picker = ImagePicker();
//   // Future imgFromGallery() async {
//   //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   //
//   //   setState(() {
//   //     if (pickedFile != null) {
//   //       _photo = File(pickedFile.path);
//   //       uploadFile();
//   //     } else {
//   //       print('No image selected.');
//   //     }
//   //   });
//   // }
//
//   // Future imgFromCamera() async {
//   //   final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//   //
//   //   setState(() {
//   //     if (pickedFile != null) {
//   //       _photo = File(pickedFile.path);
//   //       uploadFile();
//   //     } else {
//   //       print('No image selected.');
//   //     }
//   //   });
//   // }
//
//   // Future uploadFile() async {
//   //   if (_photo == null) return;
//   //   final fileName = basename(_photo!.path);
//   //   final destination = 'files/$fileName';
//   //
//   //   try {
//   //     final ref = firebase_storage.FirebaseStorage.instance
//   //         .ref(destination)
//   //         .child('file/');
//   //     await ref.putFile(_photo!);
//   //   } catch (e) {
//   //     print('error occured');
//   //   }
//   // }
//
//   // final ImagePicker imagePicker = ImagePicker();
//   // File? image;
//   // _uploadImage() async {
//   //   var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
//   //   image = File(pickedImage!.path);
//   //
//   //   setState(() {});
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//           children: [
//         SizedBox(
//           width: double.infinity,
//           height: double.infinity,
//           child: Opacity(
//             opacity: 0.2,
//             child: Image.network(
//               'https://images.pexels.com/photos/5498024/pexels-photo-5498024.jpeg?auto=compress&cs=tinysrgb&w=400',
//               fit: BoxFit.fill,
//             ),
//           ),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () => null,
//               child: SizedBox(
//                 width: 300,
//                 height: 350,
//                 // child: image == null
//                   //  ?
//                 child :Container(
//                         color: mainColor.withOpacity(0.8),
//                         child: const Icon(
//                           Icons.file_upload_outlined,
//                           size: 300,
//                           color: Colors.black,
//                         )
//                 ),
//                     //  ):null
//                     // : Image.file(image!),
//               ),
//             ),
//             const Divider(
//               color: Colors.transparent,
//             ),
//             Wrap(
//               children:[ Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 18.0, vertical: 10),
//                       child: AuthTextFromField(
//                         obscureText: false,
//                         validator: validate,
//                         hintText: 'Product name',
//                         controller: TextEditingController(),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 18.0, vertical: 10),
//                       child: AuthTextFromField(
//                         obscureText: false,
//                         validator:validate,
//
//                         hintText: 'product price',
//                         controller: _productPriceController,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 18.0, vertical: 10),
//                       child: AuthTextFromField(
//                         obscureText: false,
//                         validator: validate,
//
//                         hintText: 'product cat',
//                         controller: TextEditingController(),
//                       ),
//                     ),
//                   ],
//                 ),
//        ),]
//             ),
//             const Divider(
//               color: Colors.transparent,
//             ),
//
//             MaterialButton(
//               padding: EdgeInsets.all(20),
//               color: mainColor.withOpacity(0.8),
//               child: const Text(
//                 'upload product',
//                 style: TextStyle(fontSize: 22),
//               ),
//               onPressed: () async{
//
//
//                 if(_formKey.currentState!.validate()){
//                   // try {
//                   //   await mountainsRef.putFile(image!);
//                   // } on firebase_core.FirebaseException catch (e) {
//                   //   // ...
//                   // }
//                   FirebaseFireStoreHelper.fireStoreHelper
//                       .saveProduct(Product('testId',
//                       _productNameController.value.text,
//                       _productPriceController.value.text,
//                       'image test ',
//                   'test Cat'));
//                 }else {
//                   print('error ');
//                 }
//
//               },
//             ),
//             // image Piker (product image),
//             // text (product name)
//             // text (product categories)
//             // text (product price)
//             // button (upload product data)
//           ],
//         ),
//       ]),
//     );
//   }
//
//   String? validate(String? value) {
//     if (value!.length < 3) {
//       return 'Name must be more than 2 charater';
//     }
//     if(value!.isEmpty) {
//       return 'cant be empty';
//     } else {
//       return null;
//     }
//   }
//
//   // Future chooseFile() async {
//   //   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
//   //     setState(() {
//   //       _image = image;
//   //     });
//   //   });
//   // }
//   //
//   // Future uploadFile() async {
//   //   StorageReference storageReference = FirebaseStorage.instance
//   //       .ref()
//   //       .child('images/${Path.basename(_image.path)}}');
//   //   StorageUploadTask uploadTask = storageReference.putFile(_image);
//   //   await uploadTask.onComplete;
//   //   print('File Uploaded');
//   //   storageReference.getDownloadURL().then((fileURL) {
//   //     setState(() {
//   //       _uploadedFileURL = fileURL;
//   //     });
//   //   });
//   // }
//
//
//   // uploadImage() async {
//   //   final _firebaseStorage = FirebaseStorage.instance;
//   //   final _imagePicker = ImagePicker();
//   //   PickedFile image;
//   //   //Check Permissions
//   //   await Permission.photos.request();
//   //
//   //   var permissionStatus = await Permission.photos.status;
//   //
//   //   if (permissionStatus.isGranted){
//   //     //Select Image
//   //     image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
//   //     var file = File(image.path);
//   //
//   //     if (image != null){
//   //       //Upload to Firebase
//   //       var snapshot = await _firebaseStorage.ref()
//   //           .child('images/imageName')
//   //           .putFile(file).onComplete;
//   //       var downloadUrl = await snapshot.ref.getDownloadURL();
//   //       setState(() {
//   //         imageUrl = downloadUrl;
//   //       });
//   //     } else {
//   //       print('No Image Path Received');
//   //     }
//   //   } else {
//   //     print('Permission not granted. Try Again with permission access');
//   //   }
//   // }
// }
