import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/mark/viewmark_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/data/model/mark_model.dart';

class ViewMark extends StatelessWidget {
  const ViewMark({super.key});

  Color _markColor(int mark) {
    if (mark >= 85) return Colors.green;
    if (mark >= 60) return Colors.orange;
    return Colors.red;
  }

  IconData _examIcon(String type) {
    switch (type) {
      case "quiz":
        return Icons.quiz_rounded;
      case "mid":
        return Icons.pending_actions_rounded;
      case "final":
        return Icons.school_rounded;
      default:
        return Icons.bookmark;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ViewmarkController());
    return Scaffold(
      appBar: Customappbar(title: "Student Marks"),
      body: GetBuilder<ViewmarkController>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: controller.marksList.length,
              itemBuilder: (context, index) {
                final MarkModel m = controller.marksList[index];

                return AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 4),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // ICON SECTION
                      Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.brown.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _examIcon(m.examType ?? ""),
                          size: 28,
                          color: AppColor.primaryColor,
                        ),
                      ),

                      SizedBox(width: 12),

                      // MAIN TEXT SECTION
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m.subjectName ?? "",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  m.examDate ?? "",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),

                            SizedBox(height: 6),

                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      201,
                                      180,
                                      160,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Term ${m.term}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: AppColor.seconderyColor,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 8),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    m.examType ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // MARK BADGE
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _markColor(
                            m.studentMark ?? 0,
                          ).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${m.studentMark}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _markColor(m.studentMark ?? 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
