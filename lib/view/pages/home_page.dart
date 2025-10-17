import 'package:checkit/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() => BottomNavigationBar(
                currentIndex: homeController.selectedIndex.value,
                selectedIconTheme:
                    const IconThemeData(color: Color(0xff7C2E84), size: 30),
                unselectedIconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 203, 126, 211), size: 25),
                onTap: (index) {
                  homeController.changePage(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle), label: ""),
                  BottomNavigationBarItem(label: "", icon: Icon(Icons.settings))
                ])),
        appBar: AppBar(
          backgroundColor: const Color(0xff7C2E84),
          title: Obx(() => Text(
                homeController.currentDateTime.value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )),
          actions: [
            CircleAvatar(
              child: Image.asset(
                "assets/images/checklist.png",
                width: 30,
              ),
            ),
            const SizedBox(
              width: 12,
            )
          ],
        ),
        body: Obx(() => homeController.listWidgets
            .elementAt(homeController.selectedIndex.value)));
  }
}
