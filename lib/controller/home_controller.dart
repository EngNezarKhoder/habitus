import 'dart:async';

import 'package:checkit/view/pages/home_page_one.dart';
import 'package:checkit/view/pages/home_page_three.dart';
import 'package:checkit/view/pages/home_page_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var currentDateTime = ''.obs;
  RxInt selectedIndex = 0.obs;
  List<Widget> listWidgets = [
    const HomePageOne(),
    const HomePageTwo(),
    const HomePageThree()
  ];

  @override
  void onInit() {
    super.onInit();
    _updateDateTime();
    Timer.periodic(const Duration(seconds: 60), (_) => _updateDateTime());
  }

  void _updateDateTime() {
    final now = DateTime.now();
    currentDateTime.value = DateFormat('EEEE, MMMM d').format(now);

    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final durationUntilTomorrow = tomorrow.difference(now);
    Timer(durationUntilTomorrow, _updateDateTime);
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
