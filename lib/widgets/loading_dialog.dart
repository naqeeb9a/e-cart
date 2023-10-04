import 'package:flutter/material.dart';

showLoadingDialog({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "images/logo.png",
              fit: BoxFit.contain,
              width: 100,
              // height: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    },
  );
}
