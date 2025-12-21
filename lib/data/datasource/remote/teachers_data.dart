import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class TeachersData {
  Crud crud;
  TeachersData(this.crud);
  viewTeachersData() async {
    var response = await crud.postData(AppLink.viewTeachers, {});
    return response.fold((l) => l, (r) => r);
  }

  viewTeachersDatabyRole() async {
    var response = await crud.postData(AppLink.viewteachersbyrole, {});
    return response.fold((l) => l, (r) => r);
  }

  addTeachersData(Map data) async {
    var response = await crud.postData(AppLink.addTeachers, data);
    return response.fold((l) => l, (r) => r);
  }

  // viewSectionsData(int gradeid) async {
  //   var response = await crud.postData(AppLink.viewSections, {
  //     "gradeid": gradeid.toString(),
  //   });
  //   return response.fold((l) => l, (r) => r);
  // }
}
