import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/datasource/remote/subjects_data.dart';
import 'package:skolar/data/datasource/remote/teachers_data.dart';
import 'package:skolar/data/datasource/remote/users_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';
import 'package:skolar/data/model/subjectsmodel.dart';
import 'package:skolar/data/model/users_model.dart';

class AddTeachersController extends GetxController {
  MyServices myServices = Get.find();
  TeachersData teachersData = Get.put(TeachersData(Get.find()));

  GradesData gradesData = Get.put(GradesData(Get.find()));
  UsersData usersData = Get.put(UsersData(Get.find()));

  List<UsersModel> usersList = [];
  List<GradeModel> gradesList = [];
  List<SectionsModel> sectionsList = [];
  List<SectionsModel> filteredSections = [];

  GradeModel? gradesModel;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;

  SubjectsData subjectsData = Get.put(SubjectsData(Get.find()));

  List<SubjectsModel> subjectList = [];

  TextEditingController subjectNameController = TextEditingController();

  TextEditingController subjectIdController = TextEditingController();

  TextEditingController gradeNameController = TextEditingController();
  TextEditingController gradeIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController sectionNameController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController dropdownSelectedName = TextEditingController();
  TextEditingController dropdownSelectedID = TextEditingController();

  int? selectedUserId;

  addTeacher() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Map data = {
        "userid": selectedUserId.toString(),

        "gradeid": gradeIdController.text,
        "subjectid": subjectIdController.text,
      };

      var response = await teachersData.addTeachersData(data);
      print("===============================Controller $response");

      if (response['status'] == "failure") {
        if (response['message'].toString().contains(
          "الاستاذ المحدد موجود بالفعل",
        )) {
          Get.snackbar(
            "تنبيه",
            "هذا المستخدم مضاف بالفعل كاستاذ. اختر مستخدم آخر",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        } else {
          Get.defaultDialog(
            title: "Warning",
            middleText: response['message'].toString(),
          );
        }
        statusRequest = StatusRequest.failure;
        update();
        return;
      }

      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoutes.homePage);
        }
      } else {
        Get.snackbar("Error", "فشل الاتصال بالخادم");
      }

      update();
    }
  }

  getSubjects(int gradeId) async {
    subjectList.clear();
    statusRequest = StatusRequest.loading;
    update();
    print("Grade ID Text: '${gradeIdController.text}'");
    // int? gradeId = int.tryParse(gradeIdController.text.trim());
    // if (gradeId == null) {
    //   print("Invalid gradeId");
    //   return;
    // }

    var response = await subjectsData.viewsubjectsData(gradeId);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        subjectList.addAll(listdata.map((e) => SubjectsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getGrades() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await gradesData.viewGradesData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        gradesList.clear();
        List dataresponse = response['data'];
        gradesList.addAll(dataresponse.map((e) => GradeModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no grades");
    }
    update();
  }

  /////////////////////////////////////////////
  ///
  ///
  getSections(int gradeId) async {
    var response = await gradesData.viewSectionsData(gradeId);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        sectionsList.clear();
        List dataresponse = response['data'];
        sectionsList.addAll(dataresponse.map((e) => SectionsModel.fromJson(e)));

        sectionNameController.clear();
        sectionIdController.clear();

       
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no sections");
    }
    update(["sectionsDropdown"]);
  }

  getUsers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await teachersData.viewTeachersDatabyRole();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        usersList.clear();
        List dataresponse = response['data'];
        usersList.addAll(dataresponse.map((e) => UsersModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no users");
    }
    update();
  }

  @override
  void onInit() {
    getGrades();
    getUsers();
    super.onInit();
  }
}
