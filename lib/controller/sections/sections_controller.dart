import 'package:get/get.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';

class SectionsController extends GetxController {
  int? sectionid;
  int? gradeid;
  SectionsModel? sectionsModel;
  GradeModel? gradeModel;

  @override
  void onInit() {
    // جلب البيانات من الـ arguments
    sectionid = Get.arguments['sectionid'];
    sectionsModel = Get.arguments['sectionsmodel'];
    gradeid = Get.arguments['gradeid'];
    gradeModel = Get.arguments['gradesModel'];
    super.onInit();
  }
}
