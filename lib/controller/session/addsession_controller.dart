import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/datasource/remote/session_data.dart';
import 'package:skolar/data/datasource/remote/subjects_data.dart';
import 'package:skolar/data/datasource/remote/teachers_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';
import 'package:skolar/data/model/subjectsmodel.dart';
import 'package:skolar/data/model/teachers_model.dart';

class AddsessionController extends GetxController {
  MyServices myServices = Get.find();

  GradesData gradesData = Get.put(GradesData(Get.find()));
  SessionData sessiondata = Get.put(SessionData(Get.find()));
  SubjectsData subjectsData = Get.put(SubjectsData(Get.find()));
  TeachersData teachersData = Get.put(TeachersData(Get.find()));
  List<SelectedListItem> dayesList = [
    SelectedListItem(data: "Sun"),
    SelectedListItem(data: "Mon"),
    SelectedListItem(data: "Tue"),
    SelectedListItem(data: "Wed"),
    SelectedListItem(data: "Thu"),
  ];

  //////////List////////
  List<GradeModel> gradesList = [];

  List<SubjectsModel> subjectList = [];

  List<TeachersModel> teachersList = [];

  List<SectionsModel> sectionsList = [];

  List<SectionsModel> filteredSections = [];
  //////////////////////

  GradeModel? gradesModel;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.none;
  ///////////////////TextEditingController///////

  TextEditingController gradeNameController = TextEditingController();

  TextEditingController gradeIdController = TextEditingController();

  TextEditingController dayNameController = TextEditingController();

  TextEditingController dayIdController = TextEditingController();

  TextEditingController teacherNameController = TextEditingController();

  TextEditingController teacherIdController = TextEditingController();

  TextEditingController sectionNameController = TextEditingController();

  TextEditingController sectionIdController = TextEditingController();

  TextEditingController subjectNameController = TextEditingController();

  TextEditingController subjectIdController = TextEditingController();

  TextEditingController dropdownSelectedName = TextEditingController();

  TextEditingController dropdownSelectedID = TextEditingController();
  /////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);

  bool _endSynced = true;

  void initTimes({
    required TimeOfDay start,
    required TimeOfDay end,
    bool isNew = false,
  }) {
    startTime = start;
    endTime = end;

    if (isNew) {
      _endSynced = true;
    } else {
      _endSynced = (start.hour == end.hour && start.minute == end.minute);
    }
    update();
  }

  void updateStartTime(TimeOfDay newTime) {
    startTime = newTime;

    if (_endSynced) {
      endTime = TimeOfDay(hour: newTime.hour, minute: newTime.minute);
    }

    update();
  }

  void updateEndTime(TimeOfDay newTime) {
    endTime = newTime;

    _endSynced = false;
    update();
  }

  void syncEndToStart() {
    endTime = TimeOfDay(hour: startTime.hour, minute: startTime.minute);
    _endSynced = true;
    update();
  }

  String to24Format(TimeOfDay t) {
    final hour = t.hour.toString().padLeft(2, '0');
    final minute = t.minute.toString().padLeft(2, '0');
    return "$hour:$minute:00";
  }

  ////////////////////////////////
  addSession() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "gradeid": gradeIdController.text,
        "sectionid": sectionIdController.text,
        "subjectid": subjectIdController.text,
        "teacherid": teacherIdController.text,
        "dayofweek": dayIdController.text,
        "starttime": to24Format(startTime),
        "endtime": to24Format(endTime),
      };
      var response = await sessiondata.addData(data);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoutes.homePage);
        } else {
          Get.defaultDialog(
            title: "ُWarning",
            middleText: "Failed to add session",
          );
          statusRequest = StatusRequest.failure;
        }
        update();
      }
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////

  getSubjects() async {
    subjectList.clear();
    statusRequest = StatusRequest.loading;
    update();
    print("Grade ID Text: '${gradeIdController.text}'");
    int? gradeId = int.tryParse(gradeIdController.text.trim());
    if (gradeId == null) {
      print("Invalid gradeId");
      return;
    }

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

  /////////////////////////////////////////////
  ///
  ///
  getSections() async {
    var response = await gradesData.viewSectionsData(
      int.parse(gradeIdController.text),
    );
  كد

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

  TimeOfDay? selectedTime;
  void Function(TimeOfDay)? onTimeSelected;

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay initial = selectedTime ?? TimeOfDay.now(); //  null

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColor.seconderyColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor,
              ),
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (picked != null && onTimeSelected != null) {
      onTimeSelected!(picked);
    }
  }

  @override
  void onInit() {
    getGrades();
    getTeachers();
    super.onInit();
  }
}
