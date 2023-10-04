import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textField({
  TextInputType keyboardType = TextInputType.text,
  required TextInputAction textInputAction,
  required String hintText,
  required TextEditingController controller,
  required FocusNode focusNode,
  Function()? onTap,
  String? Function(String?)? validator,
  bool searchDelegate = false,
  bool isDroDown = false,
  bool isEye = false,
  Function()? onPressed,
  void Function(String)? onChanged,
  List<TextInputFormatter>? inputFormatters,
  bool isPassword = false,
  bool isPhone = false,
  bool isCode = false,
  bool isSearch = false,
  bool readOnly = false,
  int minLines = 1,
}) {
  return TextFormField(
    controller: controller,
    onTap: onTap,
    validator: validator,
    onChanged: onChanged,
    focusNode: focusNode,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textCapitalization: TextCapitalization.none,
    inputFormatters: inputFormatters,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    readOnly: readOnly,
    minLines: minLines,
    maxLines: isPassword ? 1 : 7,
    obscureText: isPassword,
    style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter-Medium"),
    decoration: InputDecoration(
        contentPadding:
            isSearch ? const EdgeInsets.symmetric(horizontal: 16) : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isPhone ? 0 : 8),
            topRight: Radius.circular(isCode ? 0 : 8),
            bottomLeft: Radius.circular(isPhone ? 0 : 8),
            bottomRight: Radius.circular(isCode ? 0 : 8),
          ),
          borderSide: const BorderSide(
            color: Color(0xff76B139),
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isPhone ? 0 : 8),
          topRight: Radius.circular(isCode ? 0 : 8),
          bottomLeft: Radius.circular(isPhone ? 0 : 8),
          bottomRight: Radius.circular(isCode ? 0 : 8),
        )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isPhone ? 0 : 8),
            topRight: Radius.circular(isCode ? 0 : 8),
            bottomLeft: Radius.circular(isPhone ? 0 : 8),
            bottomRight: Radius.circular(isCode ? 0 : 8),
          ),
          borderSide: const BorderSide(
            color: Color(0xffEAEAEA),
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: isEye
            ? IconButton(
                icon: Icon(isPassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined),
                onPressed: onPressed,
              )
            : isDroDown
                ? const Icon(Icons.keyboard_arrow_down)
                : null,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xffBCBCBC),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter-Medium")),
  );
}
