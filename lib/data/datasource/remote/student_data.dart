import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class StudentData {
  Crud crud;
  StudentData(this.crud);
  addData(Map data) async {
    var response = await crud.postData(AppLink.addStudent, data);
    return response.fold((l) => l, (r) => r);
  }

  viewData(int sectionid) async {
    var response = await crud.postData(AppLink.viewStudent, {
      "sectionid": sectionid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  viewStudentbyGrade(int gradeid) async {
    var response = await crud.postData(AppLink.viewstudentbygrade, {
      "gradeid": gradeid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  viewStudentbyRole() async {
    var response = await crud.postData(AppLink.viewStudentbyRole, {});
    return response.fold((l) => l, (r) => r);
  }

  searchData(String search) async {
    var response = await crud.postData(AppLink.searchstudent, {
      "search": search,
    });
    return response.fold((l) => l, (r) => r);
  }
}
