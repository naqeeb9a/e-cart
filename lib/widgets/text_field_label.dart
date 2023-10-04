import 'package:flutter/material.dart';

Widget textFieldLabel({
  required String label,
  bool isRequired = false,
}) {
  return Row(
    children: [
      if (isRequired)
        const Text(
          "* ",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xffFF5555),
            fontWeight: FontWeight.bold,
            fontFamily: "Inter-Bold",
          ),
        ),
      Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: "Inter-Bold",
        ),
      ),
    ],
  );
}
