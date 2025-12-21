import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/students/viewstudents_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/shared/searchfield.dart';
import 'package:skolar/data/model/studentmodel.dart';
import 'package:skolar/view/widget/student/liststudentsearch.dart';
import 'package:skolar/view/widget/users/customcardusers.dart';

class Viewstudents extends StatelessWidget {
  const Viewstudents({super.key});

  @override
  Widget build(BuildContext context) {
    ViewstudentsController controller = Get.put(ViewstudentsController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (controller.issearch) {
          controller.issearch = false;
          controller.update();
          return;
        }
      },
      child: Scaffold(
        body: GetBuilder<ViewstudentsController>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              margin: EdgeInsets.only(top: 40),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SearchField(
                    onFieldSubmitted: (val) {
                      controller.onSearchStudent();
                    },
                    mycontroller: controller.search,
                    onChanged: (val) {
                      controller.checkSearch(val);
                    },
                    onPressedsearch: () {
                      controller.onSearchStudent();
                    },
                    fillColor: AppColor.seconderyColor,
                    preicon: Icons.search,
                    iconColor: Colors.white,
                  ),
                  controller.issearch
                      ? Liststudentsearch(listData: controller.listdata)
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.data.length,
                            itemBuilder: (context, index) {
                              final StudentsModel model =
                                  controller.data[index];
                              return InkWell(
                                onTap: () {
                                  print(model.studentId);
                                  Get.toNamed(
                                    AppRoutes.studentdetails,
                                    arguments: {"studentid": model.studentId},
                                  );
                                },
                                child: Customcardusers(
                                  name: "${model.firstName} ${model.lastName} ",
                                  email: model.enrollmentDate!,
                                  id: model.studentCode.toString(),
                                  number: model.phone!,
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
