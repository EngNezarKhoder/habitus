import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNoteButton extends StatelessWidget {
  const MyNoteButton({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add, color: Colors.white),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              "14".tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff7C2E84),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
      ),
    );
  }
}
