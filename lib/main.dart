import 'package:checkit/locale/locale_controller.dart';
import 'package:checkit/locale/my_locale.dart';
import 'package:checkit/middleware/auth_middle_ware.dart';
import 'package:checkit/view/pages/home_page.dart';
import 'package:checkit/view/pages/home_page_one.dart';
import 'package:checkit/view/pages/home_page_three.dart';
import 'package:checkit/view/pages/home_page_two.dart';
import 'package:checkit/view/pages/login_page.dart';
import 'package:checkit/view/pages/main_page.dart';
import 'package:checkit/view/pages/sign_up_page.dart';
import 'package:checkit/view/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.put(LocaleController());
    return GetMaterialApp(
      title: "CheckIt",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      locale: localeController.myLang,
      translations: MyLocale(),
      theme: localeController.themeData,
      getPages: [
        GetPage(
          name: "/",
          page: () => const SizedBox(),
          middlewares: [AuthMiddleWare()],
        ),
        GetPage(name: "/welcome", page: () => const WelcomePage()),
        GetPage(name: "/login", page: () => const LoginPage()),
        GetPage(name: "/signup", page: () => const SignUpPage()),
        GetPage(name: "/mainpage", page: () => const MainPage()),
        GetPage(name: "/homepage", page: () => HomePage()),
        GetPage(name: "/homepageone", page: () => const HomePageOne()),
        GetPage(name: "/homepagetwo", page: () => const HomePageTwo()),
        GetPage(name: "/homepagethree", page: () => const HomePageThree()),
      ],
    );
  }
}

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 53, 53, 53),
  cardColor: const Color(0xFF1E1E1E),
  colorScheme: const ColorScheme.dark(
    primary: Colors.deepPurpleAccent,
    secondary: Colors.tealAccent,
    surface: Color(0xFF1E1E1E),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Color(0xFFBDBDBD)),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
);
