import 'package:checkit/controller/auth_controller.dart';
import 'package:checkit/view/components/my_custom_button.dart';
import 'package:checkit/view/components/my_custom_text_field_email.dart';
import 'package:checkit/view/components/my_custom_text_form_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: authController.formKey,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height +
                  MediaQuery.of(context).viewInsets.bottom,
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      top: 0,
                      child: Image.asset(
                        "assets/images/main_top.png",
                        width: 100,
                      )),
                  Positioned(
                      top: 20,
                      left: 160,
                      right: 100,
                      child: Text(
                        "1".tr,
                        style: const TextStyle(
                            fontFamily: "myfont",
                            fontSize: 30,
                            color: Color(0xff7BA9FC)),
                      )),
                  Positioned(
                      top: 100,
                      left: 30,
                      right: 30,
                      child: SvgPicture.asset(
                        "assets/icons/login.svg",
                        width: 300,
                      )),
                  Positioned(
                      left: 40,
                      right: 40,
                      top: 410,
                      child: MyCustomTextFieldEmail(
                          hintText: "nezar",
                          controller: authController.username,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "The Field Is Empty";
                            }
                            return null;
                          })),
                  Positioned(
                      left: 40,
                      right: 40,
                      top: 470,
                      child: MyCustomTextFieldEmail(
                          hintText: "xxxx@gmail.com",
                          validator: authController.validateEmail,
                          controller: authController.email)),
                  GetBuilder<AuthController>(
                    builder: (controller) {
                      return Positioned(
                          left: 40,
                          right: 40,
                          top: 530,
                          child: MyCustomTextFormPassword(
                            status: controller.obscureText,
                            controller: controller.password,
                            onPressed: () {
                              controller.changeObscureText();
                            },
                            validator: authController.validatePassword,
                          ));
                    },
                  ),
                  Positioned(
                      right: 40,
                      top: 570,
                      child: TextButton(
                          onPressed: () {
                            authController.resetYourPassword(context);
                          },
                          child: Text("5".tr))),
                  Positioned(
                      left: 40,
                      right: 40,
                      top: 610,
                      child: MyCustomButton(
                        onPressed: () {
                          authController.logInWithEmailAndPassword(context);
                        },
                        minWidth: 250,
                        height: 45,
                        buttonColor: const Color(0xff7C2E84),
                        textColor: const Color(0xffF7F6FA),
                        child: Text(
                          "1".tr,
                          style: const TextStyle(fontFamily: "myfont", fontSize: 17),
                        ),
                      )),
                  Positioned(
                      left: 10,
                      right: 10,
                      top: 660,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "6".tr,
                            style: const TextStyle(
                                fontFamily: "myfont",
                                fontSize: 17,
                                color: Color(0xff7C2E84)),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.offNamed("/signup");
                              },
                              child: Text(
                                "2".tr,
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
        ),
      )),
    );
  }
}
