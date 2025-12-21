import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/users_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/data/model/users_model.dart';
import 'package:skolar/view/widget/users/customcardusers.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewUsersController());

    return Scaffold(
      appBar: Customappbar(title: "Users"),
      body: GetBuilder<ViewUsersController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.usersList.length,
              itemBuilder: (context, index) {
                final UsersModel model = controller.usersList[index];
                return Customcardusers(
                  name: "${model.firstName!} ${model.lastName!}",
                  email: model.email!,
                  id: model.id!.toString(),
                  number: model.phone!,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
