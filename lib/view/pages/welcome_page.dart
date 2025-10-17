import 'package:checkit/main.dart';
import 'package:checkit/view/components/my_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: 100,
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: 80,
                )),
            const Positioned(
                left: 90,
                right: 10,
                top: 20,
                child: Text(
                  "Welcome To CheckIt",
                  style: TextStyle(
                      fontFamily: "myfont",
                      fontSize: 24,
                      color: Color(0xff7BA9FC)),
                )),
            Positioned(
                top: 80,
                left: 20,
                right: 20,
                child: SvgPicture.asset(
                  "assets/icons/chat.svg",
                  width: 320,
                )),
            Positioned(
                top: 480,
                left: 50,
                right: 50,
                child: MyCustomButton(
                  onPressed: () {
                    sharedPreferences!.setBool("isCalled", true);
                    Get.toNamed("/login");
                  },
                  minWidth: 250,
                  height: 45,
                  buttonColor: const Color(0xff7C2E84),
                  textColor: const Color(0xffF7F6FA),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontFamily: "myfont", fontSize: 17),
                  ),
                )),
            Positioned(
                top: 545,
                left: 50,
                right: 50,
                child: MyCustomButton(
                  onPressed: () {
                    sharedPreferences!.setBool("isCalled", true);
                    Get.toNamed("/signup");
                  },
                  minWidth: 250,
                  height: 45,
                  textColor: const Color(0xff7C2E84),
                  buttonColor: const Color.fromARGB(255, 229, 223, 247),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontFamily: "myfont", fontSize: 17),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
