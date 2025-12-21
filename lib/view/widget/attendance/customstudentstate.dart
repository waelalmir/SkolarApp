import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/attendance/viewattendance_controller.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/data/model/studentmodel.dart';

class Customstudentstate extends GetView<ViewattendanceController> {
  final StudentsModel model;
  const Customstudentstate({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            controller.attendanceStatus[model.studentId!] = "Present";
            controller.update();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: controller.attendanceStatus[model.studentId] == "Present"
                  ? Border.all(width: 3, color: Colors.green)
                  : Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightGreen,
            ),
            child: const Text("Present", style: TextStyle(color: Colors.white)),
          ),
        ),

        // ABSENT ============
        InkWell(
          onTap: () {
            controller.attendanceStatus[model.studentId!] = "Absent";
            controller.update();
            // print(model.studentId!);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: controller.attendanceStatus[model.studentId] == "Absent"
                  ? Border.all(
                      width: 3,
                      color: const Color.fromARGB(255, 181, 58, 58),
                    )
                  : Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
              color: Colors.redAccent,
            ),
            child: Text("Absent", style: TextStyle(color: AppColor.textcolor)),
          ),
        ),

        //  LATE ============
        InkWell(
          onTap: () {
            controller.attendanceStatus[model.studentId!] = "Late";
            controller.update();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: controller.attendanceStatus[model.studentId] == "Late"
                  ? Border.all(width: 3, color: AppColor.seconderyColor)
                  : Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
              color: AppColor.primaryColor,
            ),
            child: Text("Late", style: TextStyle(color: AppColor.textcolor)),
          ),
        ),
      ],
    );
  }
}
