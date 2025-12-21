import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/data/datasource/remote/student_data.dart';
import 'package:skolar/data/model/studentmodel.dart';

class SearchMixController extends GetxController {
  bool issearch = false;
  TextEditingController search = TextEditingController();
  StudentData studentData = StudentData(Get.find());
  List<StudentsModel> listdata = [];
  late StatusRequest statusRequest;

  checkSearch(val) {
    if (val == "") {
      issearch = false;
    }
    update();
  }

  onSearchStudent() {
    issearch = true;
    searchData();
    update();
  }

  searchData() async {
    listdata.clear();
    statusRequest = StatusRequest.loading;
    var response = await studentData.searchData(search.text);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        listdata.addAll(responsedata.map((e) => StudentsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  goToStudentDetails(itemsModel) {
    Get.toNamed(
      AppRoutes.studentdetails,
      arguments: {"studentdetails": itemsModel},
    );
  }
}
