import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class ExamData {
  Crud crud;
  ExamData(this.crud);
  addData(Map data) async {
    var response = await crud.postData(AppLink.addExams, data);
    return response.fold((l) => l, (r) => r);
  }

  viewData() async {
    var response = await crud.postData(AppLink.viewExams, {});
    return response.fold((l) => l, (r) => r);
  }

  viewStudentbyRole() async {
    var response = await crud.postData(AppLink.viewStudentbyRole, {});
    return response.fold((l) => l, (r) => r);
  }
}
