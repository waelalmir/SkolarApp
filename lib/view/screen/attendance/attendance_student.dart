import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/controller/attendance/attendance_controller.dart';
import 'package:skolar/core/shared/customappbar.dart';

class AttendanceStudent extends StatelessWidget {
  const AttendanceStudent({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewAttendanceController());

    return Scaffold(
      appBar: Customappbar(title: "Attendance"),
      body: GetBuilder<ViewAttendanceController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              

                /// مجموع الغيابات والتأخر والحضور
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Total Present",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "${controller.totalPresent}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Column(
                          children: [
                            Text(
                              "Total Late",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              "${controller.totalLate}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Column(
                          children: [
                            Text(
                              "Total Absent",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              "${controller.totalAbsent}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                /// جدول الحضور
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.attendance.length,
                    itemBuilder: (context, i) {
                      final item = controller.attendance[i];

                      Color statusColor;
                      if (item.status == 'Absent') {
                        statusColor = Colors.red;
                      } else if (item.status == 'Late') {
                        statusColor = Colors.orange;
                      } else {
                        statusColor = Colors.green;
                      }

                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text(item.date ?? ""),
                          trailing: Text(
                            item.status ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
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
    );
  }
}
