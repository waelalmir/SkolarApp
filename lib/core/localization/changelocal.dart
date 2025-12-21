import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/apptheme.dart';
import '../services/sevices.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myservices = Get.find();
  ThemeData appTheme = themeEn;

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myservices.sharedPrefrences.setString("lang", langcode);
    appTheme = langcode == "ar" ? themeAr : themeEn;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    // requestPermissionNotification();
    // fcmconfig();
    String? sharedPrefLang = myservices.sharedPrefrences.getString("lang");

    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      appTheme = themeAr;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      appTheme = themeEn;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
