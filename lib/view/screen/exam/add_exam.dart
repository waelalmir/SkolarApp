import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/exam/addexam_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/subjectsmodel.dart';
import 'package:skolar/view/widget/student/customgradedropdown.dart';

class AddExam extends StatelessWidget {
  const AddExam({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddexamController());
    return Scaffold(
      appBar: Customappbar(title: 'Add an Exam'),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GetBuilder<AddexamController>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    CustomGenericDropDown<GradeModel>(
                      title: "Grades",
                      listdata: controller.gradesList,
                      dropdownSelectedName: controller.gradeNameController,
                      dropdownSelectedID: controller.gradeIdController,
                      getItemName: (item) => item.name!,
                      getItemId: (item) => item.id,
                      onSelected: (selectedGrade) {
                        controller.getSubjects();
                      },
                    ),
                    CustomGenericDropDown<SubjectsModel>(
                      title: "Subjects",
                      listdata: controller.subjectList,
                      dropdownSelectedName: controller.subjectNameController,
                      dropdownSelectedID: controller.subjectIdController,
                      getItemName: (item) => item.name!,
                      getItemId: (item) => item.id,
                      onSelected: (selectedGrade) {
                        // عند اختيار صف، نجيب الأقسام التابعة له
                        controller.getSubjects();
                      },
                    ),
                    CustomGenericDropDown<SelectedListItem>(
                      title: "Term",
                      listdata: controller.examTermList,
                      dropdownSelectedName: controller.termNameController,
                      dropdownSelectedID: controller.termIdController,
                      getItemName: (item) => item.data!,
                      getItemId: (item) => item.data,
                      onSelected: (selectedGrade) {},
                    ),
                    CustomGenericDropDown<SelectedListItem>(
                      title: "Exam Type",
                      listdata: controller.examTypeList,
                      dropdownSelectedName: controller.examTypeNameController,
                      dropdownSelectedID: controller.examTypeIdController,
                      getItemName: (item) => item.data!,
                      getItemId: (item) => item.data,
                      onSelected: (selectedGrade) {},
                    ),

                    InkWell(
                      onTap: () => controller.pickDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today, color: AppColor.white),
                            SizedBox(width: 10),
                            Text(
                              "Select Exam Date",
                              style: TextStyle(color: AppColor.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // عرض التاريخ المختار
                    if (controller.selectedDate != null)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColor.seconderyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          children: [
                            Text(
                              " Selected Time: ${controller.selectedDate!.toLocal().toString().split(' ')[0]}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.textcolor,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // شرط إذا التاريخ قديم
                            if (controller.selectedDate != null)
                              controller.isExpired()
                                  ? const Text(
                                      "✅ الامتحان منتهي",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Chip(
                                      color: WidgetStatePropertyAll(
                                        AppColor.white,
                                      ),
                                      label: const Text(
                                        "📅 الامتحان لم يجرِ بعد",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                          ],
                        ),
                      ),
                    SizedBox(height: 20),
                    CustomButton(
                      onPressedUpload: () {
                        controller.addExam();
                      },
                      buttontitle: "Add an Exam",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
