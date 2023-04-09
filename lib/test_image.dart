import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {

  final ImagePicker _picker=ImagePicker();
  String? imageUrl;


  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      imageUrl ==null ? Icon(Icons.image) : InkWell(onTap: (){
        // _selectImage(),
      },),



    ],);
  }
}
