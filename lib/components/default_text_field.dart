import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final TextInputType? textInputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? Function(String?)? submit;
  final VoidCallback? changeVisibilityFunction;
  final FocusNode? focusNode;
  final TextStyle? textStyle;

  DefaultTextFormField({this.controller,
    required this.label,
    required this.validator,
    this.prefixIconData,
    this.textStyle,
    this.suffixIconData,
    this.textInputType,
    this.focusNode,
    this.submit,
    this.isPassword = false,
    this.changeVisibilityFunction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      controller: controller,
      validator: validator,
      focusNode: focusNode ,
      keyboardType: textInputType,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefixIconData,color: Colors.teal,),
        suffixIcon: IconButton(
          icon: Icon(suffixIconData),
          onPressed: changeVisibilityFunction,
        ),
      ),
      onFieldSubmitted: submit,
    );
  }
}
