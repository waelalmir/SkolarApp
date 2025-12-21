import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/teachers/viewteachers_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/data/model/teachers_model.dart';
import 'package:skolar/view/widget/users/customcardusers.dart';

class ViewTeachers extends StatelessWidget {
  const ViewTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewTeachersController());
    return Scaffold(
      appBar: Customappbar(title: "Teachers"),
      body: GetBuilder<ViewTeachersController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.teachersList.length,
              itemBuilder: (context, index) {
                final TeachersModel model = controller.teachersList[index];
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
