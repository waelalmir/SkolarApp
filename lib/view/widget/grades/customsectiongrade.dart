import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/grade/viewgrades_controller.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/functions/responsive.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';

class Customsectiongrade extends GetView<ViewGradesController> {
  final SectionsModel sectionsModel;
  final GradeModel model;
  const Customsectiongrade({
    super.key,
    required this.model,
    required this.sectionsModel,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive(context);

    return InkWell(
      onTap: () {
        controller.goToSections(
          sectionsModel.id!,
          sectionsModel,
          controller.gradesModel!,
          model,
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColor.primaryColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                sectionsModel.name ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: r.font(15),
                  color: AppColor.thirdColor,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                "Room ${sectionsModel.room ?? '-'}",
                style: TextStyle(fontSize: r.font(13), color: AppColor.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
