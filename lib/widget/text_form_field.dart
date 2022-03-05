import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({Key? key, required this.text, required this.icon, required this.textType}) : super(key: key);
  final String text;
  final Icon icon;
  final TextInputType textType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        keyboardType: textType,
        decoration: InputDecoration(
            prefixIcon: icon,
            border: OutlineInputBorder(),
            labelText: text
        ),
      ),
    );
  }
}
