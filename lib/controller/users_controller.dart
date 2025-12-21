import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/get_api.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/users_data.dart';
import 'package:skolar/data/model/users_model.dart';
import 'package:skolar/sqf/sqldb.dart';

class ViewUsersController extends GetxController {
  MyServices myServices = Get.find();
  UsersData usersData = Get.put(UsersData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;

  List<UsersModel> usersList = [];
  UsersModel? usersModel;

  SqlDb sqlDb = SqlDb();

  // getUsers() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await usersData.viewData();
  //   print("=============================== Controller $response ");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     if (response != null && response['data'] != null) {
  //       usersList.clear();
  //       List dataresponse = response['data'];
  //       usersList.addAll(dataresponse.map((e) => UsersModel.fromJson(e)));
  //     }
  //   } else {
  //     statusRequest = StatusRequest.failure;
  //     Get.snackbar("Oops", "no users");
  //   }
  //   update();
  // }

  // Future<void> loadUsers() async {
  //   usersList = await sqlDb.fetchAndCache<UsersModel>(
  //     cacheKey: "users",
  //     apiCall: () async {
  //       final res = await usersData.viewData();
  //       print("🔵 API Response = $res");
  //       // ضمان وجود data
  //       if (res["data"] is List) {
  //         return res;
  //       }
  //       return {"data": []};
  //     },
  //     fromJson: (json) => UsersModel.fromJson(json),
  //   );
  //   update();
  // }

  getUsers() async {
    statusRequest = StatusRequest.loading;
    update();

    usersList = await ApiTemplate.fetchList<UsersModel>(
      request: () => usersData.viewData(), // ← هكذا يصبح Future صحيح
      fromJson: (e) => UsersModel.fromJson(e),
      cacheKey: "users",
    );

    statusRequest = usersList.isEmpty
        ? StatusRequest.failure
        : StatusRequest.success;

    update();
  }

  Future<void> loadUsers() async {
    print("📥 Loading users from cache...");
    usersList = await sqlDb.fetchCacheOnly<UsersModel>(
      cacheKey: "users",
      fromJson: (json) => UsersModel.fromJson(json),
    );

    update();
  }

  @override
  void onInit() {
    loadUsers();

    getUsers();

    super.onInit();
  }
}
