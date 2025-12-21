import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class GradesData {
  Crud crud;
  GradesData(this.crud);
  viewGradesData() async {
    var response = await crud.postData(AppLink.viewGrade, {});
    return response.fold((l) => l, (r) => r);
  }

  viewSectionsData(int gradeid) async {
    var response = await crud.postData(AppLink.viewSections, {
      "gradeid": gradeid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
