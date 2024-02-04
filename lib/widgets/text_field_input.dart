import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool? isPass;
  final String? hintText;
  final TextInputType? textInputType;
  const TextFieldInput({
    super.key,
    this.controller,
    this.isPass,
    this.hintText,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inpputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: controller,
      obscureText: isPass ?? false,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: inpputBorder,
        focusedBorder: inpputBorder,
        focusedErrorBorder: inpputBorder,
        errorBorder: inpputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
