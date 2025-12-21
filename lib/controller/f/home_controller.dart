import 'package:get/get.dart';
import 'package:skolar/sqf/sqldb.dart';

class HomeController extends GetxController {
  SqlDb sqlDb = SqlDb();

  checkLocalRequests() async {
    final data = await sqlDb.readData("SELECT * FROM pending_request");
    print("📌 Local Pending Requests: $data");
  }

  @override
  void onInit() async {
    checkLocalRequests();
    super.onInit();
  }
}
