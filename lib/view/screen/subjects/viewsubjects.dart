import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/subjects/viewsubjects_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/data/model/subjectsmodel.dart';

class Viewsubjects extends StatelessWidget {
  const Viewsubjects({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewsubjectsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        elevation: 6,
        onPressed: () {
          Get.toNamed(AppRoutes.addsubjects);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      appBar: Customappbar(title: "Subjects"),
      body: GetBuilder<ViewsubjectsController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                final SubjectsModel model = controller.data[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),

                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.book_outlined,
                        color: AppColor.primaryColor,
                      ),
                    ),

                    title: Text(
                      model.name ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
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
