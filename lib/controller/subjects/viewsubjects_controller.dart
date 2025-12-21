import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/subjects_data.dart';
import 'package:skolar/data/model/subjectsmodel.dart';

class ViewsubjectsController extends GetxController {
  MyServices myServices = Get.find();

  SubjectsData subjectsData = Get.put(SubjectsData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;

  List<SubjectsModel> data = [];

  getSubjects(int gradeid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await subjectsData.viewsubjectsData(gradeid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        data.addAll(listdata.map((e) => SubjectsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getSubjects(Get.arguments['gradeid']);
    super.onInit();
  }
}
