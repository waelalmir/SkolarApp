import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/routes.dart';
import '../services/sevices.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    String? currentStep = myServices.sharedPrefrences.getString("step");

    if (currentStep == "2") {
      print("Middleware: Redirecting to Home Page");
      return const RouteSettings(name: AppRoutes.homePage);
    }
    if (currentStep == "1") {
      print("Middleware: Redirecting to Login");
      return const RouteSettings(name: AppRoutes.addUser);
    }

    print("Middleware: Continuing to original route (Login)");
    return null;
  }
}
