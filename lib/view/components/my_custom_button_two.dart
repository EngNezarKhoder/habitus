import 'package:flutter/material.dart';

class MyCustomButtonTwo extends StatelessWidget {
  const MyCustomButtonTwo(
      {super.key, required this.onPressed, required this.title});

  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: const Color(0xff7C2E84),
      textColor: Colors.white,
      child: Text(title),
    );
  }
}
