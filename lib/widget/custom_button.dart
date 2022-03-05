import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.width, required this.onPress, required this.icon, required this.text}) : super(key: key);
  final double width;
  final Function() onPress;
  final Icon icon;
  final Text text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        child: ElevatedButton.icon(
            onPressed: onPress,
            icon: icon,
            label: text),
      ),
    );
  }
}
