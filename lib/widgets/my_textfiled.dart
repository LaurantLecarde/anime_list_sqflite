import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.controller, required this.hintText, required this.isNumber});

  final TextEditingController controller;
  final String hintText;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white70),
      cursorColor: Colors.blue,
      keyboardType:isNumber ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        labelStyle: const TextStyle(color: Colors.indigoAccent),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.indigoAccent)
        ),enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.indigoAccent)
        ),disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.indigoAccent)
        ),
      ),
    );
  }
}
