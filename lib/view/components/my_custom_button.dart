import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton(
      {super.key,
      required this.onPressed,
      required this.minWidth,
      required this.height,
      required this.buttonColor,
      required this.textColor,
      required this.child});
  final void Function()? onPressed;
  final double minWidth;
  final double height;
  final Color buttonColor;
  final Color textColor;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        minWidth: minWidth,
        height: height,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: buttonColor,
        textColor: textColor,
        child: child);
  }
}
