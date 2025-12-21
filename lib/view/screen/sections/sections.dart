import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/sections/sections_controller.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/responsive.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/view/widget/home/customsectioncard.dart';

class Sections extends StatelessWidget {
  const Sections({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = Responsive(context); // instance للـ responsive
    final controller = Get.put(SectionsController());

    return Scaffold(
      appBar: Customappbar(title: "Sections"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(resp.padding(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // كل المحتوى بالمنتصف
          children: [
            SizedBox(height: resp.height(24)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: resp.height(14),
                horizontal: resp.width(16),
              ),
              decoration: BoxDecoration(
                color: AppColor.lightGold,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                "الشعبة: ${controller.sectionsModel!.name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: resp.font(20),
                  fontWeight: FontWeight.w700,
                  color: AppColor.thirdColor,
                ),
              ),
            ),

            SizedBox(height: resp.height(20)),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: resp.crossaxisCount(), // عدد الأعمدة ديناميكي
                crossAxisSpacing: resp.width(15),
                mainAxisSpacing: resp.height(15),
                childAspectRatio: 1.1, // نسبة الطول/العرض للكروت
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CustomSectionCard(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.students,
                        arguments: {"sectionid": controller.sectionid},
                      );
                    },
                    title: "Students",
                    icon: Icons.person_4_rounded,
                  );
                } else if (index == 1) {
                  return CustomSectionCard(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.subjects,
                        arguments: {
                          "sectionid": controller.sectionid,
                          "gradeid": controller.gradeid,
                          "gradesModel": controller.gradeModel,
                        },
                      );
                    },
                    title: "Subjects",
                    icon: Icons.book,
                  );
                } else if (index == 2) {
                  return CustomSectionCard(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.viewsession,
                        arguments: {
                          "sectionid": controller.sectionid,

                          "gradeid": controller.gradeid,
                        },
                      );
                    },
                    title: "Session",
                    icon: Icons.timer,
                  );
                } else if (index == 3) {
                  return CustomSectionCard(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.viewexam,
                        arguments: {
                          //  "sectionid": controller.sectionid,
                          "gradeid": controller.gradeid,
                        },
                      );
                    },
                    title: "Exams",
                    icon: Icons.picture_as_pdf_rounded,
                  );
                } else {
                  return CustomSectionCard(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.viewattendance,
                        arguments: {
                          "sectionid": controller.sectionid,
                          "gradeid": controller.gradeid,
                        },
                      );
                      print(controller.sectionid);
                    },

                    title: "Attendance",
                    icon: Icons.check_circle_outline,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
