import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class MarkData {
  Crud crud;
  MarkData(this.crud);
  addData(Map data) async {
    var response = await crud.postData(AppLink.addMark, data);
    return response.fold((l) => l, (r) => r);
  }

  viewData(int studentid) async {
    var response = await crud.postData(AppLink.viewMark, {
      "studentid": studentid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
