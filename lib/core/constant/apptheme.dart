import 'package:flutter/material.dart';

import 'color.dart';

ThemeData themeEn = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: AppColor.textcolor),
    backgroundColor: AppColor.primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
  ),
  fontFamily: "sans",
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: AppColor.primaryColor,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: AppColor.black,
    ),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(height: 2, color: AppColor.grey, fontSize: 14),
  ),
  primarySwatch: Colors.blue,
);
ThemeData themeAr = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
  ),
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: AppColor.black,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: AppColor.black,
    ),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(height: 2, color: AppColor.grey, fontSize: 14),
  ),
  primarySwatch: Colors.blue,
);
