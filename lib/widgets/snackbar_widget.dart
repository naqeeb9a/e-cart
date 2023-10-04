import 'package:flutter/painting.dart';
import 'package:get/get.dart';

showMessage(String message, {int seconds = 2}) {
  Get.closeAllSnackbars();
  Get.showSnackbar(
    GetSnackBar(
      message: message,
        borderRadius:10,
        margin:const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      duration: Duration(seconds: seconds),
    ),
  );
}
