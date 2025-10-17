import 'package:checkit/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  bool status = sharedPreferences!.getString("theme") == "dark";
  ThemeData themeData = sharedPreferences!.getString("theme") == "dark"
      ? darkTheme
      : ThemeData.light();
  Locale myLang = sharedPreferences!.getString("lang") == "ar"
      ? const Locale("ar")
      : const Locale("en");
  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    sharedPreferences!.setString("lang", codeLang);
    Get.updateLocale(locale);
  }

  void changeTheme(ThemeData theme) {
    themeData = theme; // <-- خزنا الثيم الجديد
    status = theme == darkTheme; // <-- حدّثنا قيمة السويتش
    Get.changeTheme(theme);
    update(); // <-- حدث الواجهة
  }
}
