import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/constant/routes.dart';

class StudentsdetailsController extends GetxController {
  late int studentID;
  List<Map<String, dynamic>> get items => [
    {
      "title": "Edit details",
      "icon": Icons.edit_note_rounded,
      "onTap": () =>
          Get.toNamed(AppRoutes.viewmark, arguments: {"studentid": studentID}),
    },
    {
      "title": "Marks",
      "icon": Icons.pending_actions_rounded,
      "onTap": () =>
          Get.toNamed(AppRoutes.viewmark, arguments: {"studentid": studentID}),
    },

    {
      "title": "Attendance",
      "icon": Icons.assignment_turned_in_sharp,
      "onTap": () => Get.toNamed(
        AppRoutes.attendanceStudent,
        arguments: {"studentid": studentID},
      ),
    },
  ];

  @override
  void onInit() {
    studentID = Get.arguments['studentid'];
    super.onInit();
  }
}
