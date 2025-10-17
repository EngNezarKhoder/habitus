import 'package:checkit/view/components/my_custom_button_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الصورة في الأعلى
              SvgPicture.asset(
                "assets/icons/signup.svg",
                width: 330,
              ),
              const SizedBox(height: 60),
        
              // العنوان
              const Text(
                "Habitat",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff7C2E84),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Build Habits and routines",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 133, 86, 139),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: MyCustomButtonTwo(
                  onPressed: () {
                    Get.offAllNamed("/homepage");
                  },
                  title: "9".tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
