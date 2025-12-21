import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/datasource/remote/subjects_data.dart';
import 'package:skolar/data/model/grade_model.dart';

class AddsubjectsController extends GetxController {
  MyServices myServices = Get.find();
  SubjectsData subjectsData = Get.put(SubjectsData(Get.find()));
  GradesData gradesData = Get.put(GradesData(Get.find()));

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController name = TextEditingController();
  GradeModel? gradesModel;

  TextEditingController gradeNameController = TextEditingController();

  TextEditingController gradeIdController = TextEditingController();

  List<GradeModel> data = [];

  int? gradeid;

  addSubject() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map data = {"name": name.text, "gradeid": gradeid.toString()};
      var response = await subjectsData.addsubjectsData(data);
      print("===============================Controller $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoutes.homePage);
        } else {
          Get.defaultDialog(
            title: "ُWarning",
            middleText: "Failed to add subject",
          );
          statusRequest = StatusRequest.failure;
        }
        update();
      }
    }
  }

  getGrades() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await gradesData.viewGradesData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        data.clear();
        List dataresponse = response['data'];
        data.addAll(dataresponse.map((e) => GradeModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no grades");
    }
    update();
  }

  @override
  void onInit() {
    getGrades();
    super.onInit();
  }
}
