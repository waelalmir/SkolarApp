import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/exam/viewexam_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/data/model/exam_model.dart';

class ViewExam extends StatelessWidget {
  const ViewExam({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewexamController());
    return Scaffold(
      appBar: Customappbar(title: "Exams"),
      body: GetBuilder<ViewexamController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                final ExamModel model = controller.data[index];
                return Card(
                  color: AppColor.lightGold,
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // المادة والصف
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.subjectName ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.seconderyColor,
                              ),
                            ),
                            Text(
                              model.gradeName ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.seconderyColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // نوع الامتحان والفصل
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              label: Text(
                                model.examType ?? "",
                                style: TextStyle(color: AppColor.white),
                              ),
                              backgroundColor: AppColor.primaryColor,
                            ),
                            Text(
                              "Term: ${model.term ?? ""}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: AppColor.seconderyColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // التاريخ
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date: ${model.examDate ?? ""}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColor.seconderyColor,
                              ),
                            ),
                            controller.isExamExpired(model.examDate)
                                ? Chip(
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          Icons.check_circle,
                                          color: Color(0xff2e7d32),
                                          size: 18,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "Exam Finished",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: AppColor.white,
                                  )
                                : Chip(
                                    label: const Text(
                                      "📅 Upcoming Exam",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    backgroundColor: AppColor.white,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
