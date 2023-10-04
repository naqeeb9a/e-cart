import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHelper{
  Future<File?> getImage(
      ImagePicker imagePicker, ImageSource imageSource) async {
    final pickedFile =
    await imagePicker.pickImage(source: imageSource);
    return pickedFile == null ? null : File(pickedFile.path);
  }
}