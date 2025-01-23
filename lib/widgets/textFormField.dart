import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Widget iconWidget;
  final int maxLength;
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.iconWidget,
      required this.maxLength,
      required this.validator,
      this.keyBoardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        controller: controller,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: iconWidget,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
