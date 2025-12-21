import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class UsersData {
  Crud crud;
  UsersData(this.crud);

  // Future<dynamic> sendRequest(String url, Map<String, dynamic> data) async {
  //   var response = await crud.postData(url, data);
  //   return response.fold((l) => l, (r) => r);
  // }

  Future<Map<String, dynamic>> sendRequest(
    String url,
    Map<String, dynamic> data,
  ) async {
    final response = await crud.postData(url, data);

    return response.fold(
      (l) => {"status": "error", "message": l.toString()},
      (r) => {
        "status": "success",
        "message": "Request successful",
        "data": r, // ممكن تحط البيانات تحت مفتاح data
      },
    );
  }

  Future<dynamic> addData(Map<String, dynamic> data) async {
    return await sendRequest(AppLink.addUser, data);
  }

  // addData(Map data) async {
  //   var response = await crud.postData(AppLink.addUser, data);
  //   return response.fold((l) => l, (r) => r);
  // }

  viewData() async {
    var response = await crud.postData(AppLink.viewUser, {});

    return response.fold(
      (l) => {"status": "error", "data": []}, // في حالة الخطأ
      (r) => r is Map<String, dynamic> ? r : {"status": "error", "data": []},
    );
  }
}
