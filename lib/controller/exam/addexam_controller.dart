import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/exam_data.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/datasource/remote/subjects_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/subjectsmodel.dart';

class AddexamController extends GetxController {
  MyServices myServices = Get.find();

  GradesData gradesData = Get.put(GradesData(Get.find()));
  ExamData examData = Get.put(ExamData(Get.find()));

  SubjectsData subjectsData = Get.put(SubjectsData(Get.find()));

  List<SelectedListItem> examTypeList = [
    SelectedListItem(data: "quiz"),
    SelectedListItem(data: "mid"),
    SelectedListItem(data: "final"),
  ];
  List<SelectedListItem> examTermList = [
    SelectedListItem(data: "1"),
    SelectedListItem(data: "2"),
  ];

  List<GradeModel> gradesList = [];

  List<SubjectsModel> subjectList = [];

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.none;

  TextEditingController gradeNameController = TextEditingController();

  TextEditingController gradeIdController = TextEditingController();

  TextEditingController subjectNameController = TextEditingController();

  TextEditingController subjectIdController = TextEditingController();

  TextEditingController termNameController = TextEditingController();

  TextEditingController termIdController = TextEditingController();

  TextEditingController examTypeNameController = TextEditingController();

  TextEditingController examTypeIdController = TextEditingController();

  DateTime? selectedDate;

  addExam() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "gradeid": gradeIdController.text,
        "subjectid": subjectIdController.text,
        "examdate": selectedDate.toString(),
        "term": termIdController.text,
        "examtype": examTypeIdController.text,
      };
      var response = await examData.addData(data);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoutes.homePage);
        } else {
          Get.defaultDialog(
            title: "ُWarning",
            middleText: "Failed to add Exam",
          );
          statusRequest = StatusRequest.failure;
        }
        update();
      }
    }
  }

  // دالة لفتح الـ DatePicker وتحديث القيمة
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor, // 🔵 اليوم المختار + الهيدر
              onPrimary: Colors.white, // النص داخل اليوم المختار
              surface: Colors.white, // خلفية الكاليندر
              onSurface: AppColor.seconderyColor, // نص الأيام
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor, // أزرار OK / CANCEL
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }

  // دالة منطقية للتحقق إذا التاريخ المختار قديم
  bool isExpired() {
    if (selectedDate == null) return false;
    return DateTime.now().isAfter(selectedDate!);
  }

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
    super.onInit();
  }
}
