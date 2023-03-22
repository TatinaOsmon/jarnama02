// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFild extends StatelessWidget {
  const CustomTextFild({
    super.key,
    required this.hintText,
    this.controller,
    this.onTap,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
  });

  final String? hintText;
  final TextEditingController? controller;
  final void Function()? onTap;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: maxLines,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText ?? '',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
