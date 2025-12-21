import 'package:get/get.dart';

import '../services/sevices.dart';

translateDataBase(columnar, columnen) {
  MyServices myServices = Get.find();

  if (myServices.sharedPrefrences.getString("lang") == "ar") {
    return columnar;
  } else {
    return columnen;
  }
}
