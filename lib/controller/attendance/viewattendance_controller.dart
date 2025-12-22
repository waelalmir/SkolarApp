import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/attendance_data.dart';
import 'package:skolar/data/datasource/remote/student_data.dart';
import 'package:skolar/data/model/studentmodel.dart';

class ViewattendanceController extends GetxController {
  MyServices myServices = Get.find();

  AttendanceData attendanceData = Get.put(AttendanceData(Get.find()));

  List<SelectedListItem> statusList = [
    SelectedListItem(data: "Present"),
    SelectedListItem(data: "Absent"),
    SelectedListItem(data: "Late"),
  ];

  Map<int, String> attendanceStatus = {};

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.none;

  StudentData studentData = Get.put(StudentData(Get.find()));

  List<StudentsModel> studentList = [];

  TextEditingController dateController = TextEditingController();

  addAttendance(String studentid, String date, String status) async {
    statusRequest = StatusRequest.loading;
    update();

    Map data = {"studentid": studentid, "date": date, "status": status};

    var response = await attendanceData.addData(data);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['status'] == "success") {
        Get.snackbar("Success", "Attendance added successfully");
      } else {
        statusRequest = StatusRequest.failure;
        Get.snackbar("Oops", "Failed to add attendance");
      }
    }
    update();
  }

  sendAllAttendance() async {
    String date = dateController.text;

    attendanceStatus.forEach((studentId, status) {
      addAttendance(studentId.toString(), date, status);
    });

    Get.snackbar("Done", "Attendance sent for all students");
  }

  getStudent(int sectionid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentData.viewData(sectionid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        studentList.clear();
        List dataresponse = response['data'];
        studentList.addAll(dataresponse.map((e) => StudentsModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no students");
    }
    update();
  }

  attendanceSelect(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      // barrierColor: AppColor.seconderyColor, // background
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor, 
              onPrimary: AppColor.textcolor,
              onSurface: Colors.black, 
            ),
            // dialogTheme: DialogThemeData(
            //   backgroundColor: const Color.fromARGB(255, 78, 78, 78),
            // ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formatted = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text = formatted;
      update();
    }
  }

  @override
  void onInit() {
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    getStudent(Get.arguments['sectionid']);
    print(dateController.text);
    super.onInit();
  }
}
