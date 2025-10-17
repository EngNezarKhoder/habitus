import 'package:checkit/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool obscureText = true;
  bool isLoading = false;

  void changeObscureText() {
    obscureText = !obscureText;
    update();
  }

  Future<void> signOut(context) async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed("/login");
  }

  Future<void> logInWithEmailAndPassword(context) async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading = true;
        update();
        FocusScope.of(context).unfocus();
        final credential = await _auth.signInWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
        if (credential.user != null) {
          if (credential.user!.emailVerified) {
            FocusScope.of(context).unfocus();
            sharedPreferences!.setString(
              "${FirebaseAuth.instance.currentUser!.uid}_email",
              email.text,
            );
            sharedPreferences!.setString(
              "${FirebaseAuth.instance.currentUser!.uid}_username",
              username.text,
            );

            Get.offAllNamed("/mainpage");
          } else {
            isLoading = false;
            update();
            credential.user!.sendEmailVerification();
            _showAwesmDialog(
                onPressed: () {
                  Get.back();
                },
                title: 'Warning',
                dialogColor: Colors.red,
                content: 'Please Verify Your Email And Try Again.',
                iconDialog: Icons.warning);
          }
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        update();
        if (e.code == 'user-not-found') {
          _showAwesmDialog(
              onPressed: () {
                Get.back();
              },
              title: 'Error',
              dialogColor: Colors.red,
              content: 'No user found for that email.',
              iconDialog: Icons.error);
        } else if (e.code == 'wrong-password') {
          _showAwesmDialog(
              onPressed: () {
                Get.back();
              },
              title: 'Error',
              dialogColor: Colors.red,
              content: 'Wrong password provided for that user.',
              iconDialog: Icons.error);
        } else if (e.code == 'invalid-credential') {
          _showAwesmDialog(
              onPressed: () {
                Get.back();
              },
              title: 'Error',
              dialogColor: Colors.red,
              content: 'The credentials are invalid or expired.',
              iconDialog: Icons.error);
        } else {
          _showAwesmDialog(
              onPressed: () {
                Get.back();
              },
              title: 'Error',
              dialogColor: Colors.red,
              content: 'An unknown error occurred.',
              iconDialog: Icons.error);
        }
      } catch (e) {
        _showAwesmDialog(
            onPressed: () {
              Get.back();
            },
            title: 'Error',
            dialogColor: Colors.red,
            content: 'An unexpected error occurred. Please try again later.',
            iconDialog: Icons.error);
      }
    }
  }

  Future<void> createAccountWithEmailAndPassword(context) async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading = true;
        update();
        FocusScope.of(context).unfocus();
        final credential = await _auth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        if (credential.user != null) {
          credential.user!.sendEmailVerification();
          _showAwesmDialog(
              titleButton: "Continue",
              title: "warning",
              iconDialog: Icons.warning,
              content: "PLease Go To Email And The Verifed It And Then Login",
              onPressed: () async {
                Get.back();
                Get.offNamed("/login");
              },
              dialogColor: Colors.red);
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        update();
        if (e.code == 'weak-password') {
          _showAwesmDialog(
              title: "Error",
              dialogColor: Colors.red,
              iconDialog: Icons.error,
              content: "The password provided is too weak.",
              onPressed: () {
                Get.back();
              });
        } else if (e.code == 'email-already-in-use') {
          _showAwesmDialog(
              title: "Error",
              dialogColor: Colors.red,
              iconDialog: Icons.error,
              content: "The account already exists for that email.",
              onPressed: () {
                Get.back();
              });
        }
      } catch (e) {
        isLoading = false;
        update();
        _showAwesmDialog(
            title: "Error",
            dialogColor: Colors.red,
            iconDialog: Icons.error,
            content: "An unexpected error occurred. Please try again later.",
            onPressed: () {
              Get.back();
            });
      }
    }
  }

  Future<void> resetYourPassword(context) async {
    if (email.text.isEmpty) {
      _showAwesmDialog(
          title: "Error",
          dialogColor: Colors.red,
          iconDialog: Icons.error,
          content: "Please Write Your Email And Try Again.",
          onPressed: () {
            Get.back();
          });
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      _showAwesmDialog(
          title: "Warning",
          dialogColor: Colors.red,
          iconDialog: Icons.warning,
          content: "Please Go To Your Email And Reset Your Password.",
          onPressed: () {
            Get.back();
          });
    } catch (e) {
      _showAwesmDialog(
          title: "Error",
          dialogColor: Colors.red,
          iconDialog: Icons.error,
          content: "Please Make Sure You Entered Your Email Correctly.",
          onPressed: () {
            Get.back();
          });
    }
  }

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return "The field is empty";
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "The field is empty";
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }
}

void _showAwesmDialog(
    {String title = "Error",
    String titleButton = "Ok",
    Color dialogColor = Colors.red,
    IconData iconDialog = Icons.error,
    String content = "",
    required void Function()? onPressed}) {
  Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(
        color: dialogColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        children: [
          Icon(
            iconDialog,
            color: dialogColor,
            size: 70,
          ),
          const SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      radius: 15,
      confirm: SizedBox(
        width: 140,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: dialogColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            titleButton,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ));
}
