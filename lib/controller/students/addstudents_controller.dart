import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/datasource/remote/student_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';
import 'package:skolar/data/model/users_model.dart';

class AddStudentsController extends GetxController {
  MyServices myServices = Get.find();
  StudentData studentData = Get.put(StudentData(Get.find()));

  GradesData gradesData = Get.put(GradesData(Get.find()));

  List<UsersModel> usersList = [];
  List<GradeModel> gradesList = [];
  List<SectionsModel> sectionsList = [];
  List<SectionsModel> filteredSections = [];

  GradeModel? gradesModel;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;

  TextEditingController gradeNameController = TextEditingController();
  TextEditingController gradeIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController sectionNameController = TextEditingController();
  TextEditingController sectionIdController = TextEditingController();
  TextEditingController dropdownSelectedName = TextEditingController();
  TextEditingController dropdownSelectedID = TextEditingController();

  int? selectedUserId;

  addStudent() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Map data = {
        "user_id": selectedUserId.toString(),
        "dob": dateController.text,
        "grade_id": gradeIdController.text,
        "section_id": sectionIdController.text,
      };

      var response = await studentData.addData(data);
      print("===============================Controller $response");

      if (response['status'] == "failure") {
        if (response['message'].toString().contains(
          "المستخدم المحدد موجود بالفعل",
        )) {
          Get.snackbar(
            "تنبيه",
            "هذا المستخدم مضاف بالفعل كطالب. اختر مستخدم آخر",
            backgroundColor: Colors.red,
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

  dobSelect(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formatted =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      dateController.text = formatted;
      update();
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
    print(
      "=============================== Sections response $response",
    );

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        sectionsList.clear();
        List dataresponse = response['data'];
        sectionsList.addAll(dataresponse.map((e) => SectionsModel.fromJson(e)));

        sectionNameController.clear();
        sectionIdController.clear();

        print(
          "Sections fetched: ${sectionsList.length}",
        );
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
    var response = await studentData.viewStudentbyRole();
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
