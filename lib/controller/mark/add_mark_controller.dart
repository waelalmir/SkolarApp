import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/exam_data.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/datasource/remote/mark_data.dart';
import 'package:skolar/data/datasource/remote/student_data.dart';
import 'package:skolar/data/model/exam_model.dart';
import 'package:skolar/data/model/studentmodel.dart';

class AddMarkController extends GetxController {
  MyServices myServices = Get.find();

  MarkData markData = Get.put(MarkData(Get.find()));

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.none;

  StudentData studentData = Get.put(StudentData(Get.find()));

  List<StudentsModel> studentsList = [];
  List<ExamModel> examsList = [];

  TextEditingController studentIdController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();

  TextEditingController examIdController = TextEditingController();
  TextEditingController examNameController = TextEditingController();

  TextEditingController mark = TextEditingController();

  ExamData examData = Get.put(ExamData(Get.find()));

  GradesData gradesData = Get.put(GradesData(Get.find()));

  addMark() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "examid": examIdController.text,
        "studentid": studentIdController.text,
        "mark": mark.text,
      };
      var response = await markData.addData(data);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoutes.homePage);
        } else {
          Get.defaultDialog(
            title: "ُWarning",
            middleText: "Failed to add mark for student",
          );
          statusRequest = StatusRequest.failure;
        }
        update();
      }
    }
  }

  getStudent() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentData.viewStudentbyRole();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        studentsList.clear();
        List dataresponse = response['data'];
        studentsList.addAll(dataresponse.map((e) => StudentsModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no students on this Grade");
    }
    update();
  }

  getExams() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await examData.viewData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        examsList.clear();
        List dataresponse = response['data'];
        examsList.addAll(dataresponse.map((e) => ExamModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no Exams");
    }
    update();
  }

  @override
  void onInit() {
    getStudent();
    getExams();
    super.onInit();
  }
}
