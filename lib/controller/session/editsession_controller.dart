import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/datasource/remote/session_data.dart';
import 'package:skolar/data/datasource/remote/subjects_data.dart';
import 'package:skolar/data/datasource/remote/teachers_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';
import 'package:skolar/data/model/session_model.dart';
import 'package:skolar/data/model/subjectsmodel.dart';
import 'package:skolar/data/model/teachers_model.dart';

class EditsessionController extends GetxController {
  MyServices myServices = Get.find();

  GradesData gradesData = Get.put(GradesData(Get.find()));
  SessionData sessiondata = Get.put(SessionData(Get.find()));
  SubjectsData subjectsData = Get.put(SubjectsData(Get.find()));
  TeachersData teachersData = Get.put(TeachersData(Get.find()));

  SessionModel? sessionModel;

  List<SelectedListItem> dayesList = [
    SelectedListItem(data: "Sun"),
    SelectedListItem(data: "Mon"),
    SelectedListItem(data: "Tue"),
    SelectedListItem(data: "Wed"),
    SelectedListItem(data: "Thu"),
  ];

  ////////// Lists //////////
  List<GradeModel> gradesList = [];
  List<SubjectsModel> subjectList = [];
  List<TeachersModel> teachersList = [];
  List<SectionsModel> sectionsList = [];
  List<SectionsModel> filteredSections = [];
  //////////////////////

  GradeModel? gradesModel;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;

  ////////////////// TextEditingControllers //////////////////
  late TextEditingController gradeNameController;
  late TextEditingController gradeIdController;
  late TextEditingController dayNameController;
  late TextEditingController dayIdController;
  late TextEditingController teacherNameController;
  late TextEditingController teacherIdController;
  late TextEditingController sectionNameController;
  late TextEditingController sectionIdController;
  late TextEditingController subjectNameController;
  late TextEditingController subjectIdController;
  late TextEditingController dropdownSelectedName;
  late TextEditingController dropdownSelectedID;
  ////////////////////////////////////////////////////////////

  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);

  void updateStartTime(TimeOfDay newTime) {
    startTime = newTime;
    endTime = TimeOfDay(hour: newTime.hour, minute: newTime.minute);
    update();
  }

  void updateEndTime(TimeOfDay newTime) {
    endTime = newTime;
    update();
  }

  String to24Format(TimeOfDay t) {
    final hour = t.hour.toString().padLeft(2, '0');
    final minute = t.minute.toString().padLeft(2, '0');
    return "$hour:$minute:00";
  }

  ////////////////////////////////
  editSession() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "id": sessionModel!.id.toString(),
        "gradeid": gradeIdController.text,
        "sectionid": sectionIdController.text,
        "subjectid": subjectIdController.text,
        "teacherid": teacherIdController.text,
        "dayofweek": dayIdController.text,
        "starttime": to24Format(startTime),
        "endtime": to24Format(endTime),
      };
      var response = await sessiondata.editData(data);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoutes.homePage);
        } else {
          Get.defaultDialog(
            title: "ُWarning",
            middleText: "Failed to edit session",
          );
          statusRequest = StatusRequest.failure;
        }
        update();
      }
    }
  }

  getSubjects() async {
    subjectList.clear();
    statusRequest = StatusRequest.loading;
    update();
    int? gradeId = int.tryParse(gradeIdController.text.trim());
    if (gradeId == null) return;

    var response = await subjectsData.viewsubjectsData(gradeId);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest &&
        response['status'] == "success") {
      List listdata = response['data'];
      subjectList.addAll(listdata.map((e) => SubjectsModel.fromJson(e)));
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  getTeachers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await teachersData.viewTeachersData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest &&
        response['status'] == "success") {
      List listdata = response['data'];
      teachersList.addAll(listdata.map((e) => TeachersModel.fromJson(e)));
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  getGrades() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await gradesData.viewGradesData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest && response['data'] != null) {
      gradesList.clear();
      List dataresponse = response['data'];
      gradesList.addAll(dataresponse.map((e) => GradeModel.fromJson(e)));
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no grades");
    }
    update();
  }

  getSections() async {
    var response = await gradesData.viewSectionsData(
      int.parse(gradeIdController.text),
    );
    print("=============================== Sections response $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest && response['data'] != null) {
      sectionsList.clear();
      List dataresponse = response['data'];
      sectionsList.addAll(dataresponse.map((e) => SectionsModel.fromJson(e)));
      sectionNameController.clear();
      sectionIdController.clear();
      print("Sections fetched: ${sectionsList.length}");
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no sections");
    }
    update(["sectionsDropdown"]);
  }

  @override
  void onInit() async {
    super.onInit();

    gradeNameController = TextEditingController();
    gradeIdController = TextEditingController();
    dayNameController = TextEditingController();
    dayIdController = TextEditingController();
    teacherNameController = TextEditingController();
    teacherIdController = TextEditingController();
    sectionNameController = TextEditingController();
    sectionIdController = TextEditingController();
    subjectNameController = TextEditingController();
    subjectIdController = TextEditingController();
    dropdownSelectedName = TextEditingController();
    dropdownSelectedID = TextEditingController();

    sessionModel = Get.arguments['sessionModel'];

    gradeIdController.text = sessionModel!.gradeId.toString();
    sectionIdController.text = sessionModel!.sectionId.toString();
    subjectIdController.text = sessionModel!.subjectId.toString();
    teacherIdController.text = sessionModel!.teacherId.toString();
    dayIdController.text = sessionModel!.dayOfWeek!;
    dayNameController.text = sessionModel!.dayOfWeek!;
    startTime = TimeOfDay(
      hour: int.parse(sessionModel!.startTime!.split(":")[0]),
      minute: int.parse(sessionModel!.startTime!.split(":")[1]),
    );
    endTime = TimeOfDay(
      hour: int.parse(sessionModel!.endTime!.split(":")[0]),
      minute: int.parse(sessionModel!.endTime!.split(":")[1]),
    );

    await getGrades();

    await getSubjects();

    await getTeachers();
    var teacher = teachersList.firstWhere(
      (e) => e.teacherId == sessionModel!.teacherId,
      orElse: () => TeachersModel(id: 0, firstName: "Ts"),
    );
    teacherNameController.text = teacher.firstName!;

    var sub = subjectList.firstWhere(
      (e) => e.id == sessionModel!.subjectId,
      orElse: () => SubjectsModel(id: 0, name: "Unknown"),
    );
    var grade = gradesList.firstWhere(
      (e) => e.id == sessionModel!.gradeId,
      orElse: () => GradeModel(id: 0, name: "Unknown"),
    );

    subjectNameController.text = sub.name!;
    gradeNameController.text = grade.name!;

    await getSections();
    var section = sectionsList.firstWhere(
      (e) => e.id == sessionModel!.sectionId,
      orElse: () => SectionsModel(id: 0, name: "Unknown"),
    );
    sectionNameController.text = section.name!;
    sectionIdController.text = section.id.toString();

    update();
  }
}
