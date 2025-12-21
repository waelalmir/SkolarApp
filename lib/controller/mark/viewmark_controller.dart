import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/mark_data.dart';
import 'package:skolar/data/model/mark_model.dart';

class ViewmarkController extends GetxController {
  MyServices myServices = Get.find();

  MarkData markData = Get.put(MarkData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;
  late int studentId;
  List<MarkModel> marksList = [];
  getMarks() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await markData.viewData(studentId);
    // ignore: avoid_print
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        marksList.clear();
        List dataresponse = response['data'];
        marksList.addAll(dataresponse.map((e) => MarkModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no marks");
    }
    update();
  }

  @override
  void onInit() {
    studentId = Get.arguments['studentid'];
    getMarks();
    super.onInit();
  }
}
