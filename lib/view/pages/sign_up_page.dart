import 'package:checkit/controller/auth_controller.dart';
import 'package:checkit/view/components/my_custom_button.dart';
import 'package:checkit/view/components/my_custom_text_field_email.dart';
import 'package:checkit/view/components/my_custom_text_form_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: authController.formKey,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height +
                MediaQuery.of(context).viewInsets.bottom,
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/signup_top.png",
                      width: 110,
                    )),
                Positioned(
                    top: 20,
                    left: 160,
                    right: 90,
                    child: Text(
                      "2".tr,
                      style: const TextStyle(
                          fontFamily: "myfont",
                          fontSize: 30,
                          color: Color(0xff7BA9FC)),
                    )),
                Positioned(
                    top: 60,
                    left: 30,
                    right: 30,
                    child: SvgPicture.asset(
                      "assets/icons/signup.svg",
                      width: 280,
                    )),
                Positioned(
                    left: 40,
                    right: 40,
                    top: 400,
                    child: MyCustomTextFieldEmail(
                        hintText: "xxxx@gmail.com",
                        validator: authController.validateEmail,
                        controller: authController.email)),
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return Positioned(
                        left: 40,
                        right: 40,
                        top: 470,
                        child: MyCustomTextFormPassword(
                          status: controller.obscureText,
                          validator: authController.validatePassword,
                          controller: controller.password,
                          onPressed: () {
                            controller.changeObscureText();
                          },
                        ));
                  },
                ),
                Positioned(
                    left: 40,
                    right: 40,
                    top: 540,
                    child: MyCustomButton(
                      onPressed: () {
                        authController
                            .createAccountWithEmailAndPassword(context);
                      },
                      minWidth: 250,
                      height: 45,
                      buttonColor: const Color(0xff7C2E84),
                      textColor: const Color(0xffF7F6FA),
                      child: Text(
                        "2".tr,
                        style:
                            const TextStyle(fontFamily: "myfont", fontSize: 17),
                      ),
                    )),
                Positioned(
                    left: 10,
                    right: 10,
                    top: 595,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "4".tr,
                          style: const TextStyle(
                              fontFamily: "myfont",
                              fontSize: 17,
                              color: Color(0xff7C2E84)),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.offNamed("/login");
                            },
                            child: Text(
                              "1".tr,
                              style: const TextStyle(fontSize: 14),
                            ))
                      ],
                    )),
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return controller.isLoading
                        ? Container(
                            color: Colors.black.withOpacity(0.3),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff7C2E84),
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(""),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
