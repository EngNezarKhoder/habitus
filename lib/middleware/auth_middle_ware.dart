import 'package:checkit/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    bool? isCalled = sharedPreferences!.getBool("isCalled");
    if (isCalled == null) {
      return const RouteSettings(name: "/welcome");
    }
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified) {
      return const RouteSettings(name: "/homepage");
    } else {
      return const RouteSettings(name: "/login");
    }
  }
}
