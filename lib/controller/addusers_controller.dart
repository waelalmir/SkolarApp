import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/checkinternet.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/core/services/sevices.dart';
import 'package:skolar/data/datasource/remote/users_data.dart';
import 'package:skolar/linkapi.dart';
import 'package:skolar/sqf/sqldb.dart';

class AddusersController extends GetxController {
  MyServices myServices = Get.find();
  UsersData usersData = Get.put(UsersData(Get.find()));
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  List<SelectedListItem> rolesList = [
    SelectedListItem(data: "Admin"),
    SelectedListItem(data: "Principal"),
    SelectedListItem(data: "Teacher"),
    SelectedListItem(data: "Student"),
    SelectedListItem(data: "Parent"),
    SelectedListItem(data: "Staff"),
  ];
  TextEditingController roleNameController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();

  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController role;

  SqlDb sqlDb = SqlDb();

  addUser() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Map<String, dynamic> data = {
        "role": roleIdController.text,
        "email": email.text,
        "phone": phone.text,
        "first_name": firstName.text,
        "last_name": lastName.text,
        "password": password.text,
      };

      final online = await checkInternet();

      if (online) {
        var response = await usersData.addData(data);
        print("=== Online Response: $response");

        if (response == null) {
          print("=== Server Offline → Saving Local");

          int id = await sqlDb.insertRequest(AppLink.addUser, data);
          print("🟡 Offline Request Saved with ID: $id → $data");

          var allRequests = await sqlDb.getAllRequests();
          print("📌 Local Pending Requests After Insert: $allRequests");
          return;
        }

        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            Get.offNamed(AppRoutes.homePage);
          } else {
            Get.defaultDialog(
              title: "ُWarning",
              middleText: "Failed to SignUp",
            );
          }
        }

        update();
        return;
      } else {
        print("🟡 Saving Offline Request: $data");
        await sqlDb.insertRequest(AppLink.addUser, data);
        var allRequests = await sqlDb.getAllRequests();
        print("📌 Local Pending Requests After Insert: $allRequests");
        statusRequest = StatusRequest.success;
        print(data);
        update();

        Get.snackbar(
          "Offline",
          " تم حفظ المستخدم وسيتم إرساله عند توفر الانترنت",
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onInit() {
    // // ignore: unused_element
    // Future<void> deleteOldDB() async {
    //   final dbPath = join(await getDatabasesPath(), 'pending_requests.db');
    //   await deleteDatabase(dbPath);
    //   print("Old database deleted");
    // }

    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    role = TextEditingController();
    super.onInit();
  }
}
