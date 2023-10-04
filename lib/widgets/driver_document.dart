import 'package:dotted_border/dotted_border.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildAddImage(Map data, Function()? onTap, Function()? onRemove) =>
    Column(
      children: [
        DottedBorder(
          dashPattern: const [10, 6],
          borderType: BorderType.RRect,
          radius: const Radius.circular(8),
          color: const Color(0xffC1BDBD),
          child: Container(
              width: Get.width,
              height: 100,
              padding: data["file"] == null
                  ? null
                  : data["file"].path.toString().split(".").last == "pdf" ||
                          data["file"].path.toString().split(".").last ==
                              "doc" ||
                          data["file"].path.toString().split(".").last == "docx"
                      ? const EdgeInsets.symmetric(vertical: 16)
                      : null,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                clipBehavior: Clip.none,
                children: [
                  data["file"].path == ""
                      ? GestureDetector(
                          onTap: onTap,
                          child: Chip(
                            label: const Icon(Icons.add, color: Colors.white),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: const Color(0xff76B139),
                          ),
                        )
                      : data["file"].path.toString().split(".").last == "pdf"
                          ? Image.asset(
                              "images/pdf.png",
                            )
                          : Image.asset(
                              "images/word.png",
                            ),
                  if (data["file"].path != "")
                    Positioned(
                      right: 4,
                      top: -13,
                      child: FloatingActionButton(
                          onPressed: onRemove,
                          mini: true,
                          backgroundColor: Colors.green,
                          child: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          )),
                    )
                ],
              )),
        ),
        const SizedBox(height: 16),
        Text(
          data["title"],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: FontConstants.bold,
          ),
        )
      ],
    );
