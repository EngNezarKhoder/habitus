import 'package:checkit/controller/auth_controller.dart';
import 'package:checkit/locale/locale_controller.dart';
import 'package:checkit/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageThree extends StatelessWidget {
  const HomePageThree({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    LocaleController localeController = Get.find();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF7B61FF),
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                sharedPreferences!.getString(
                        "${FirebaseAuth.instance.currentUser!.uid}_username") ??
                    "No username",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                sharedPreferences!.getString(
                        "${FirebaseAuth.instance.currentUser!.uid}_email") ??
                    "No email",
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.language, color: Color(0xFF7B61FF)),
              title: Text("15".tr),
              subtitle: const Text("English / العربية"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                if (sharedPreferences!.getString("lang") == null ||
                    sharedPreferences!.getString("lang") == 'en') {
                  localeController.changeLang("ar");
                } else {
                  localeController.changeLang("en");
                }
              },
            ),
          ),
          const SizedBox(height: 12),
          GetBuilder<LocaleController>(
            builder: (controller) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: SwitchListTile(
                  value: controller.status,
                  onChanged: (val) {
                    if (val) {
                      sharedPreferences!.setString("theme", "dark");
                      controller.changeTheme(darkTheme);
                    } else {
                      sharedPreferences!.setString("theme", "light");
                      controller.changeTheme(ThemeData.light());
                    }
                  },
                  secondary: Icon(
                      !controller.status ? Icons.dark_mode : Icons.light_mode,
                      color: const Color(0xFF7B61FF)),
                  title: !controller.status ? Text("16".tr) : Text("18".tr),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.red[50],
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                "17".tr,
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {
                authController.signOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
