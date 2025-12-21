import 'package:get/get.dart';
import 'package:skolar/controller/searchmixcontroller.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/student_data.dart';
import 'package:skolar/data/model/studentmodel.dart';

class ViewstudentsController extends SearchMixController {
  MyServices myServices = Get.find();
  StudentData studentData = Get.put(StudentData(Get.find()));

  StatusRequest statusRequest = StatusRequest.none;

  List<StudentsModel> data = [];

  getStudent(int sectionid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentData.viewData(sectionid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        data.clear();
        List dataresponse = response['data'];
        data.addAll(dataresponse.map((e) => StudentsModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no students");
    }
    update();
  }

  @override
  void onInit() {
    getStudent(Get.arguments['sectionid']);
    super.onInit();
  }
}
