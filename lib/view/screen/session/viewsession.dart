import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/session/viewsession_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/functions/responsive.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/view/screen/session/editsession.dart';
import 'package:skolar/view/widget/session/customsessionbox.dart';

class Viewsession extends StatelessWidget {
  const Viewsession({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewsessionController());
    final Responsive r = Responsive(context);

    return Scaffold(
      backgroundColor: AppColor.lightGold,

      appBar: Customappbar(title: "Weekly Schedule"),
      body: GetBuilder<ViewsessionController>(
        builder: (controller) {
          final days = controller.days;

          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: EdgeInsets.all(r.padding(8)),
              child: ListView.builder(
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = controller.days[index];
                  final sessions = controller.groupedSessions[day]!;
                  return Container(
                    margin: EdgeInsets.only(bottom: r.height(14)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(r.width(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ExpansionTile(
                          collapsedBackgroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          iconColor: AppColor.primaryColor,
                          collapsedIconColor: AppColor.primaryColor,

                          tilePadding: EdgeInsets.symmetric(
                            horizontal: r.padding(12),
                            vertical: r.padding(8),
                          ),

                          // collapsedIconColor: AppColor.seconderyColor,
                          // iconColor: AppColor.seconderyColor,
                          title: Text(
                            day,
                            style: TextStyle(
                              color: AppColor.thirdColor,
                              fontSize: r.font(18),
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          children: [
                            Padding(
                              padding: EdgeInsets.all(r.padding(12)),
                              child: Column(
                                children: sessions.map((s) {
                                  return Container(
                                    padding: EdgeInsets.all(r.padding(12)),
                                    margin: EdgeInsets.only(
                                      bottom: r.height(10),
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.lightGold,
                                      borderRadius: BorderRadius.circular(
                                        r.width(14),
                                      ),
                                      border: Border.all(
                                        color: AppColor.primaryColor
                                            .withOpacity(0.25),
                                      ),
                                    ),

                                    child: Column(
                                      children: [
                                        // زر التعديل
                                        // -------------------------
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                // ✅ الانتقال لصفحة التعديل
                                                Get.to(
                                                  () => Editsession(),
                                                  arguments: {
                                                    "sessionModel": s,
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: AppColor.primaryColor,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller.deleteSession(
                                                  s.id.toString(),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.delete_outline_rounded,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: r.height(5)),
                                        Row(
                                          children: [
                                            Customsessionbox(
                                              r: r,
                                              title: "Subject",
                                              value: s.subjectName!,
                                            ),
                                            SizedBox(width: r.width(10)),
                                            Customsessionbox(
                                              r: r,
                                              title: "Teacher",
                                              value: s.teacherFullName!,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: r.height(10)),
                                        Row(
                                          children: [
                                            Customsessionbox(
                                              r: r,
                                              title: "Start",
                                              value: s.startTime ?? "",
                                            ),
                                            SizedBox(width: r.width(10)),
                                            Customsessionbox(
                                              r: r,
                                              title: "End",
                                              value: s.endTime ?? "",
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: r.height(10)),
                                        Row(
                                          children: [
                                            Customsessionbox(
                                              r: r,
                                              title: "Grade",
                                              value: s.gradeName!,
                                            ),
                                            SizedBox(width: r.width(10)),
                                            Customsessionbox(
                                              r: r,
                                              title: "Section",
                                              value: s.sectionName!,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
