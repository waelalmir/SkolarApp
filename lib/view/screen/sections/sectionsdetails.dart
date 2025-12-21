import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/sections/sectionsdetailscontroller.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/view/widget/home/customsectioncard.dart';

class Sectionsdetails extends StatelessWidget {
  const Sectionsdetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Sectionsdetailscontroller());
    return Scaffold(
      appBar: Customappbar(title: "Sections"),
      body: GetBuilder<Sectionsdetailscontroller>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.sections.isEmpty) {
            return Center(child: Text("No data"));
          }
          return Column(
            children: [
              Center(
                child: Text(
                  "${controller.sections[0].name!} :الشعبة",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.thirdColor,
                  ),
                ),
              ),
              GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10, right: 10, top: 50),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: [
                  CustomSectionCard(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.students,
                        arguments: {"sectionid": controller.sections[0].id},
                      );
                    },
                    title: "Students",
                    icon: Icons.person_4_rounded,
                  ),
                  CustomSectionCard(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.students,
                        arguments: {"sectionid": controller.sections[0].id},
                      );
                    },
                    title: "subjects",
                    icon: Icons.book,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
