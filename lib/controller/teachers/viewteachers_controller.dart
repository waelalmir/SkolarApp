import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/datasource/remote/teachers_data.dart';
import 'package:skolar/data/datasource/remote/users_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/teachers_model.dart';

class ViewTeachersController extends GetxController {
  MyServices myServices = Get.find();
  UsersData usersData = Get.put(UsersData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;
  GradesData gradesData = Get.put(GradesData(Get.find()));

  TeachersData teachersData = Get.put(TeachersData(Get.find()));

  List<GradeModel> gradesList = [];

  List<TeachersModel> teachersList = [];

  GradeModel? gradesModel;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController gradeNameController = TextEditingController();

  TextEditingController gradeIdController = TextEditingController();

  TextEditingController teacherNameController = TextEditingController();

  TextEditingController teacherIdController = TextEditingController();

  getTeachers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await teachersData.viewTeachersData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        teachersList.addAll(listdata.map((e) => TeachersModel.fromJson(e)));
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

  @override
  void onInit() {
    getGrades();
    getTeachers();
    super.onInit();
  }
}
