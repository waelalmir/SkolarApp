import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class SessionData {
  Crud crud;
  SessionData(this.crud);

  addData(Map data) async {
    var response = await crud.postData(AppLink.addSession, data);
    return response.fold((l) => l, (r) => r);
  }

  editData(Map data) async {
    var response = await crud.postData(AppLink.editSession, data);
    return response.fold((l) => l, (r) => r);
  }

  deleteData(Map data) async {
    var response = await crud.postData(AppLink.deleteSession, data);
    return response.fold((l) => l, (r) => r);
  }

  viewData(int sectionid) async {
    var response = await crud.postData(AppLink.viewSession, {
      "sectionid": sectionid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
