import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class SubjectsData {
  Crud crud;
  SubjectsData(this.crud);
  viewsubjectsData(int gradeid) async {
    var response = await crud.postData(AppLink.viewSubjects, {
      "gradeid": gradeid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  addsubjectsData(Map data) async {
    var response = await crud.postData(AppLink.addSubjects, data);
    return response.fold((l) => l, (r) => r);
  }
}
