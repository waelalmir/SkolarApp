import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class AttendanceData {
  Crud crud;
  AttendanceData(this.crud);
  addData(Map data) async {
    var response = await crud.postData(AppLink.addAttendance, data);
    return response.fold((l) => l, (r) => r);
  }

  viewData(int studentid) async {
    var response = await crud.postData(AppLink.viewAttendance, {
      "studentid": studentid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
