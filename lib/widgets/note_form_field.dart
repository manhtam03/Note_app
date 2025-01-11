import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.autofocus = false,
    this.filled,
    this.fillColor,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.keyboardType,
  });

  final String? hintText;
  final String? labelText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool autofocus;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  @override

  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: autofocus,
        key: key,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          labelText: labelText,
          filled: filled,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red)
          ),
        ),
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
    );
  }
}
