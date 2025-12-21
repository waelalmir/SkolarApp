import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  Responsive(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // حجم الخط حسب الشاشة
  double font(double size) {
    if (screenWidth < 600) return size; // موبايل صغير
    if (screenWidth < 1000) return size * 1.2; // تابلت / شاشة متوسطة
    return size * 1.5; // كمبيوتر
  }

  double height(double size) {
    if (screenWidth < 600) return size;
    if (screenWidth < 1000) return size * 1.2;
    return size * 1.5;
  }

  double width(double size) {
    if (screenWidth < 600) return size;
    if (screenWidth < 1000) return size * 1.2;
    return size * 1.5;
  }

  double icon(double size) {
    if (screenWidth < 600) return size;
    if (screenWidth < 1000) return size * 1.2;
    return size * 1.5;
  }

  double padding(double size) {
    if (screenWidth < 600) return size;
    if (screenWidth < 1000) return size * 1.2;
    return size * 1.5;
  }

  double crossaAxisCount() {
    if (screenWidth >= 1200) {
      return 4; // كمبيوتر كبير
    } else if (screenWidth >= 800) {
      return 3; // تابلت كبير / شاشة متوسطة
    } else if (screenWidth >= 450) {
      return 2; // تابلت صغير / موبايل أفقياً
    } else {
      return 2; // موبايل عمودي
    }
  }

  // عدد الأعمدة ديناميكي
  int crossaxisCount() {
    if (screenWidth >= 1200) return 4;
    if (screenWidth >= 800) return 3;
    if (screenWidth >= 450) return 2;
    return 2;
  }

  // نسبة الطول/العرض للكروت
  double childAspectRatio() {
    if (screenWidth >= 1200) return 1.2;
    if (screenWidth >= 800) return 1;
    if (screenWidth >= 450) return 0.9;
    return 0.8;
  }
}
