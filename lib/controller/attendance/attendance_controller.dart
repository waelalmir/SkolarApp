import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/attendance_data.dart';
import 'package:skolar/data/model/attendance_model.dart';

class ViewAttendanceController extends GetxController {
  MyServices myServices = Get.find();
  AttendanceData attendanceData = Get.put(AttendanceData(Get.find()));

  StatusRequest statusRequest = StatusRequest.none;

  late int studentID;

  List<AttendanceModel> attendance = [];
  int totalAbsent = 0;
  int totalLate = 0;
  int totalPresent = 0;

  getAttendance() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await attendanceData.viewData(studentID);
    print("======================= Attendance Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        List attList = response['data']['attendance'];
        var totals = response['data']['totals'];

        attendance.clear();
        attendance.addAll(attList.map((e) => AttendanceModel.fromJson(e)));

        totalAbsent = int.tryParse(totals['total_absent'].toString()) ?? 0;
        totalLate = int.tryParse(totals['total_late'].toString()) ?? 0;
        totalPresent = int.tryParse(totals['total_present'].toString()) ?? 0;
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "No attendance records found");
    }

    update();
  }

  @override
  void onInit() {
    studentID = Get.arguments['studentid'];
    getAttendance();
    super.onInit();
  }
}
