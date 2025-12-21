import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/grades_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';

class Sectionsdetailscontroller extends GetxController {
  MyServices myServices = Get.find();
  GradesData gradesData = Get.put(GradesData(Get.find()));

  StatusRequest statusRequest = StatusRequest.none;

  List<GradeModel> data = [];
  List<SectionsModel> sections = [];
  SectionsModel? sectionsModel;

  getSections(int sectionid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await gradesData.viewSectionsData(sectionid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        sections.clear();
        List dataresponse = response['data'];
        sections.addAll(dataresponse.map((e) => SectionsModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no sections");
    }
    update();
  }

  @override
  void onInit() {
    int sectionid = Get.arguments['sectionid'];
    getSections(sectionid);
    print(sectionid);
    super.onInit();
  }
}
