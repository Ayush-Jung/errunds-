import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) saved;
  final Function(String) onvalidate;
  final String label, initialValue;
  final TextInputType textInputType;
  final bool obscureText;
  const CustomTextField({
    Key key,
    this.saved,
    this.onvalidate,
    this.label,
    this.textInputType,
    this.obscureText = false,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        keyboardType: textInputType,
        obscureText: obscureText,
        initialValue: initialValue,
        decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          labelText: label,
        ),
        validator: (value) => onvalidate(value),
        onSaved: (value) => saved(value),
      ),
    );
  }
}
