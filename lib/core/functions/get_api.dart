import 'package:get/get.dart';
import '../class/statusrequest.dart';
import 'handlingdatacontroller.dart';
import '../../sqf/sqldb.dart';

typedef JsonToModel<T> = T Function(Map<String, dynamic> json);
SqlDb sqlDb = SqlDb();

class ApiTemplate {
  static Future<List<T>> fetchList<T>({
    required Future<dynamic> Function() request,
    required JsonToModel<T> fromJson,
    required String cacheKey,
  }) async {
    // 1) طلب API
    var response = await request();
    var status = handlingData(response);

    // 2) لو فشل
    if (status != StatusRequest.success) {
      Get.snackbar("Error", "Something went wrong");
      return [];
    }

    // 3) تحويل البيانات
    List data = response['data'];
    List<T> list = data.map((e) => fromJson(e)).toList();

    // 4) حفظ كاش
    await sqlDb.saveCache(key: cacheKey, data: data);

    return list;
  }
}
