import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/session_data.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/session_model.dart';

class ViewsessionController extends GetxController {
  MyServices myServices = Get.find();

  SessionData sessionData = Get.put(SessionData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;
  int? sectionid;
  List<SessionModel> data = [];

  Map<String, List<SessionModel>> groupedSessions = {};
  List<String> days = [];
  GradeModel? grademodel;

  void groupSessionByDay() {
    Map<String, List<SessionModel>> grouped = {};

    for (var item in data) {
      final day = item.dayOfWeek ?? "Unknown";
      grouped.putIfAbsent(day, () => []);
      grouped[day]!.add(item);
    }

    groupedSessions = grouped;
    days = grouped.keys.toList();

    update(); 
  }

  deleteSession(String id) async {
    groupedSessions.clear();
    statusRequest = StatusRequest.loading;
    update();
    Map map = {"id": id};
    var response = await sessionData.deleteData(map);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      refreshSession();
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "Items not delete it");
    }
    update();
  }

  refreshSession() {
    if (sectionid != null) {
      getSession(sectionid!); 
    }
  }

  getSession(int sectionid) async {
    this.sectionid = sectionid;
    statusRequest = StatusRequest.loading;
    update();
    var response = await sessionData.viewData(sectionid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => SessionModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
      groupSessionByDay(); 
    }
    update();
  }

  @override
  void onInit() {
    getSession(Get.arguments['sectionid']);
    grademodel = Get.arguments['gradesModel'];

    super.onInit();
  }
}
