import 'package:flutter/material.dart';

class MyCustomTextFormPassword extends StatelessWidget {
  const MyCustomTextFormPassword(
      {super.key,
      required this.controller,
      required this.onPressed,
      required this.status,
      required this.validator});
  final TextEditingController controller;
  final void Function()? onPressed;
  final bool status;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: TextFormField(
          validator: validator,
          obscureText: status,
          controller: controller,
          decoration: InputDecoration(
              hintText: "Nezar@12",
              hintStyle: const TextStyle(
                  fontFamily: "myfont", color: Color(0xff7C2E84)),
              contentPadding: const EdgeInsets.all(10),
              prefixIcon: const Icon(
                Icons.lock,
              ),
              suffixIcon: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Color(0xff7C2E84),
                  )),
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
