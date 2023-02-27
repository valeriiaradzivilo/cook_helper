import 'package:cook_helper/additional_classes/color_palette.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../recipes_work/recipe.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({Key? key, required this.currentRecipe}) : super(key: key);
  final Recipe currentRecipe;
  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File? _image;
  bool isPicked = false;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
        isPicked = true;
        widget.currentRecipe.imageUrl = _image;
      });
    } else {
      print('No image selected.');
    }
  }

  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: !isPicked
          ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPalette.lightOrange,
              ),
              onPressed: _pickImage,
              icon: Icon(Icons.photo),
              label: Text("Pick image"))
          : Image.file(_image!),
    );
  }
}
