import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/exam_data.dart';
import 'package:skolar/data/model/exam_model.dart';

class ViewexamController extends GetxController {
  MyServices myServices = Get.find();
  ExamData examData = Get.put(ExamData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;

  List<ExamModel> data = [];
  ExamModel? examModel;

  DateTime? examDateTime;
  bool isExamExpired(String? examDate) {
    if (examDate == null) return false;

    final DateTime? examDateTime = DateTime.tryParse(examDate);
    if (examDateTime == null) return false;

    return DateTime.now().isAfter(examDateTime);
  }

  getExams() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await examData.viewData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        data.clear();
        List dataresponse = response['data'];
        data.addAll(dataresponse.map((e) => ExamModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no Exams");
    }
    update();
  }

  @override
  void onInit() {
    getExams();
    super.onInit();
  }
}
