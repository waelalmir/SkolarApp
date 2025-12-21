import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/session/editsession_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';
import 'package:skolar/data/model/subjectsmodel.dart';
import 'package:skolar/data/model/teachers_model.dart';
import 'package:skolar/view/widget/student/customgradedropdown.dart';

class Editsession extends StatelessWidget {
  const Editsession({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditsessionController());
    return Scaffold(
      appBar: Customappbar(title: "Add session"),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GetBuilder<EditsessionController>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // عرض الوقت الحالي
                        Text(
                          "Start Time: ${controller.startTime.format(context)}",
                        ),
                        SizedBox(height: 10),
                        Text("End Time: ${controller.endTime.format(context)}"),
                        SizedBox(height: 20),

                        // زر اختيار start time
                        ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: controller.startTime,
                              // barrierColor: AppColor.primaryColor,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      onSurfaceVariant: AppColor.black,
                                      onPrimaryFixedVariant: AppColor.white,
                                      onTertiaryContainer: AppColor.white,
                                      //  tertiaryContainer: AppColor.black,
                                      onTertiaryFixedVariant: AppColor.black,
                                      tertiary: AppColor.seconderyColor,
                                      onTertiaryFixed: AppColor.black,
                                      tertiaryFixed: AppColor.black,

                                      primary: AppColor
                                          .primaryColor, // لون زر التأكيد
                                      onPrimary:
                                          Colors.white, // لون نص زر التأكيد
                                      surface: Colors.white, // خلفية الديالوج
                                      onSurface: AppColor
                                          .seconderyColor, // لون النصوص في الوقت
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColor
                                            .primaryColor, // لون نص أزرار Cancel/OK
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              controller.updateStartTime(picked);
                            }
                          },
                          child: Text("Pick Start Time"),
                        ),
                        SizedBox(height: 10),

                        // زر اختيار end time
                        ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: controller.endTime,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      onSurfaceVariant: AppColor.black,
                                      onPrimaryFixedVariant: AppColor.white,
                                      onTertiaryContainer: AppColor.white,
                                      //  tertiaryContainer: AppColor.black,
                                      onTertiaryFixedVariant: AppColor.black,
                                      tertiary: AppColor.seconderyColor,
                                      onTertiaryFixed: AppColor.black,
                                      tertiaryFixed: AppColor.black,

                                      primary: AppColor
                                          .primaryColor, // لون زر التأكيد
                                      onPrimary:
                                          Colors.white, // لون نص زر التأكيد
                                      surface: Colors.white, // خلفية الديالوج
                                      onSurface: AppColor
                                          .seconderyColor, // لون النصوص في الوقت
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColor
                                            .primaryColor, // لون نص أزرار Cancel/OK
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              controller.updateEndTime(picked);
                            }
                          },
                          child: Text("Pick End Time"),
                        ),
                      ],
                    ),
                    CustomGenericDropDown<SelectedListItem>(
                      title: "Day",
                      listdata: controller.dayesList,
                      dropdownSelectedName: controller.dayNameController,
                      dropdownSelectedID: controller.dayIdController,
                      getItemName: (item) => item.data!,
                      getItemId: (item) => item.data,
                      onSelected: (selectedGrade) {},
                    ),
                    CustomGenericDropDown<GradeModel>(
                      title: "Grades",
                      listdata: controller.gradesList,
                      dropdownSelectedName: controller.gradeNameController,
                      dropdownSelectedID: controller.gradeIdController,
                      getItemName: (item) => item.name!,
                      getItemId: (item) => item.id,
                      onSelected: (selectedGrade) {
                        // عند اختيار صف، نجيب الأقسام التابعة له
                        controller.getSections();
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
                    CustomGenericDropDown<TeachersModel>(
                      title: "Teachers",
                      listdata: controller.teachersList,
                      dropdownSelectedName: controller.teacherNameController,
                      dropdownSelectedID: controller.teacherIdController,
                      getItemName: (item) => item.firstName!,
                      getItemId: (item) => item.teacherId,
                      onSelected: (t) {
                        print("selected teacher ${t.original.teacherId}");
                      },
                    ),

                    GetBuilder<EditsessionController>(
                      id: "sectionsDropdown",
                      builder: (controller) {
                        return CustomGenericDropDown<SectionsModel>(
                          title: "Sections",
                          listdata: controller.sectionsList,
                          dropdownSelectedName:
                              controller.sectionNameController,
                          dropdownSelectedID: controller.sectionIdController,
                          getItemName: (item) => item.name!,
                          getItemId: (item) => item.id,
                        );
                      },
                    ),
                    CustomButton(
                      buttontitle: "edit session",
                      onPressedUpload: () {
                        controller.editSession();
                      },
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
