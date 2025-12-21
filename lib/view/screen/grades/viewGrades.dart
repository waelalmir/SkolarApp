import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/grade/viewgrades_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/functions/responsive.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/view/widget/grades/customsectiongrade.dart';

class ViewGrades extends StatelessWidget {
  const ViewGrades({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewGradesController());
    final Responsive r = Responsive(context);

    return Scaffold(
      appBar: Customappbar(title: "Grades"),
      body: GetBuilder<ViewGradesController>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  GradeModel model = controller.data[index];
                  controller.currentIndex = index;
                  return Column(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: Container(
                          margin: EdgeInsets.only(bottom: r.height(14)),
                          decoration: BoxDecoration(
                            color: AppColor.lightGold,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppColor.primaryColor.withValues(
                                alpha: 0.25,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.black.withValues(alpha: 0.05),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ExpansionTile(
                              onExpansionChanged: (isExpanded) {
                                if (isExpanded) {
                                  controller.toggle(index, model);
                                }
                              },

                              tilePadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              childrenPadding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 16,
                              ),

                              backgroundColor: AppColor.lightGold,
                              collapsedBackgroundColor: AppColor.lightGold,

                              iconColor: AppColor.primaryColor,
                              collapsedIconColor: AppColor.primaryColor
                                  .withValues(alpha: 0.6),

                              title: Text(
                                model.name ?? "",
                                style: TextStyle(
                                  fontSize: r.font(19),
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.thirdColor,
                                  letterSpacing: 0.3,
                                ),
                              ),

                              children: [
                                if ((controller.gradeSections[model.id] ?? [])
                                    .isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "No sections found",
                                      style: TextStyle(color: AppColor.white),
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                          .gradeSections[model.id]!
                                          .length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: r.crossaxisCount(),
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 1.5,
                                          ),
                                      itemBuilder: (context, sectionIndex) {
                                        final d =
                                            controller.gradeSections[model
                                                .id]![sectionIndex];
                                        return Customsectiongrade(
                                          model: model,
                                          sectionsModel: d,
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Divider(),
                    ],
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
