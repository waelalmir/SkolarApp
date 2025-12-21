import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/attendance/viewattendance_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/imageasset.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/data/model/studentmodel.dart';
import 'package:skolar/view/widget/attendance/customstudentstate.dart';

class ViewAttendance extends StatelessWidget {
  const ViewAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    ViewattendanceController controller = Get.put(ViewattendanceController());

    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 30, right: 10, left: 10),
        child: CustomButton(
          buttontitle: "Send Attendance",
          onPressedUpload: () {
            controller.sendAllAttendance();
          },
        ),
      ),
      appBar: Customappbar(title: "Attendance"),
      body: GetBuilder<ViewattendanceController>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Column(
              children: [
                //  Date ==========
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      controller.attendanceSelect(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.lightGold,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date: ${controller.dateController.text}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //  Student section  =========
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.studentList.length,
                    itemBuilder: (context, index) {
                      final StudentsModel model = controller.studentList[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey.shade200,
                                    child: ClipOval(
                                      child: Image.asset(
                                        AppImageAsset.personprofile,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "${model.firstName} ${model.lastName}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),

                              Customstudentstate(model: model),
                              //////////////////////////
                              ////////////////////
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
