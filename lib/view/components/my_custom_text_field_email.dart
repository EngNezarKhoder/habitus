import 'package:flutter/material.dart';

class MyCustomTextFieldEmail extends StatelessWidget {
  const MyCustomTextFieldEmail(
      {super.key,
      required this.controller,
      required this.validator,
      required this.hintText});
  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontFamily: "myfont", color: Color(0xff7C2E84)),
              contentPadding: const EdgeInsets.all(10),
              prefixIcon: const Icon(
                Icons.person,
              ),
              prefixIconColor: const Color(0xff7C2E84),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              fillColor: const Color.fromARGB(137, 168, 137, 209),
              filled: true),
        ));
  }
}
