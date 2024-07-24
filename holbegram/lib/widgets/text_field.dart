import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput(
      {super.key,
      required this.ispassword,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      required this.keyboardType});

  final TextEditingController controller;
  final bool ispassword;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: const Color.fromARGB(218, 226, 37, 24),
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: suffixIcon,
      ),
      textInputAction: TextInputAction.next,
      obscureText: ispassword,
    );
  }
}
