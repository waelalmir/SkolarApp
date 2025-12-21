import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/session/addsession_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';
import 'package:skolar/data/model/subjectsmodel.dart';
import 'package:skolar/data/model/teachers_model.dart';
import 'package:skolar/view/widget/session/customcontainertime.dart';
import 'package:skolar/view/widget/student/customgradedropdown.dart';

class Addsession extends StatelessWidget {
  const Addsession({super.key});

  @override
  Widget build(BuildContext context) {
    AddsessionController controller = Get.put(AddsessionController());
    controller.initTimes(
      start: TimeOfDay(hour: 12, minute: 0),
      end: TimeOfDay(hour: 12, minute: 0),
      isNew: true,
    );

    return Scaffold(
      appBar: Customappbar(title: "Add session"),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: GetBuilder<AddsessionController>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    Customcontainertime(),

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
                        controller.getSections();
                        controller.getSubjects();
                      },
                    ),

                    CustomGenericDropDown<SubjectsModel>(
                      alertext: "choose grade first",
                      isavailable: controller.gradeIdController.text.isNotEmpty,
                      title: "Subjects",
                      listdata: controller.subjectList,
                      dropdownSelectedName: controller.subjectNameController,
                      dropdownSelectedID: controller.subjectIdController,
                      getItemName: (item) => item.name!,
                      getItemId: (item) => item.id,
                      onSelected: (selectedGrade) {
                        // // عند اختيار صف، نجيب الأقسام التابعة له
                        // controller.getSubjects();
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

                    GetBuilder<AddsessionController>(
                      id: "sectionsDropdown",
                      builder: (controller) {
                        return CustomGenericDropDown<SectionsModel>(
                          isavailable:
                              controller.gradeIdController.text.isNotEmpty,

                          alertext: "choose grade first",
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
                      buttontitle: "Add session",
                      onPressedUpload: () {
                        controller.addSession();
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
