import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';

class ViewGradesController extends GetxController {
  MyServices myServices = Get.find();
  GradesData gradesData = Get.put(GradesData(Get.find()));

  StatusRequest statusRequest = StatusRequest.none;

  List<GradeModel> data = [];
  List<SectionsModel> sections = [];
  Map<int, List<SectionsModel>> gradeSections = {};

  bool loadingDetails = false;
  GradeModel? gradesModel;
  SectionsModel? sectionsModel;
  var isOpen = false;
  int? openIndex;
  int? currentIndex;

  toggle(int index, GradeModel grade) async {
    if (openIndex == index) {
      openIndex = null;
      update();
      return;
    }

    openIndex = index;
    gradesModel = grade;
    loadingDetails = true;
    update();

    if (!gradeSections.containsKey(grade.id)) {
      await getSections(grade.id!);
    }

    loadingDetails = false;
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

  getSections(int gradeid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await gradesData.viewSectionsData(gradeid);
    print("=============================== getSections($gradeid): $response");

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        List dataresponse = response['data'];
        List<SectionsModel> list = dataresponse
            .map((e) => SectionsModel.fromJson(e))
            .toList();
        gradeSections[gradeid] = list; 
      }
    } else {
      gradeSections[gradeid] = [];
    }

    update();
  }

  getAllSections() async {
    if (data.isEmpty) return;

    statusRequest = StatusRequest.loading;
    update();

    gradeSections.clear();

    for (var grade in data) {
      var response = await gradesData.viewSectionsData(grade.id!);
      print("================ getSections for Grade ${grade.id}: $response");

      StatusRequest status = handlingData(response);

      if (status == StatusRequest.success &&
          response != null &&
          response['data'] != null) {
        List dataresponse = response['data'];
        List<SectionsModel> list = dataresponse
            .map((e) => SectionsModel.fromJson(e))
            .toList();
        gradeSections[grade.id!] = list;
      } else {
        gradeSections[grade.id!] = [];
      }
    }

    statusRequest = StatusRequest.success;
    update();
  }

  goToSections(
    int sectionid,
    SectionsModel section,
    GradeModel gradeid,
    GradeModel gradesModel,
  ) {
    Get.toNamed(
      AppRoutes.sections,
      arguments: {
        "sectionid": sectionid,
        "sectionsmodel": section,
        "gradeid": gradeid.id,
        "gradesModel": gradesModel,
      },
    );
  }

  @override
  void onInit() async {
    await getGrades();
    await getAllSections();
    super.onInit();
  }
}
