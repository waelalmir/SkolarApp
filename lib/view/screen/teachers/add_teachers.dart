import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/teachers/addteachers_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/subjectsmodel.dart';
import 'package:skolar/data/model/users_model.dart';
import 'package:skolar/view/widget/student/customgradedropdown.dart';

class AddTeachers extends StatelessWidget {
  const AddTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    // AddusersController controller =
    Get.put(AddTeachersController());
    return Scaffold(
      appBar: Customappbar(title: "Add Teacher"),
      body: GetBuilder<AddTeachersController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formstate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView(
                children: [
                  CustomGenericDropDown<UsersModel>(
                    title: "Users",
                    listdata: controller.usersList,
                    dropdownSelectedName: controller.dropdownSelectedName,
                    dropdownSelectedID: controller.dropdownSelectedID,
                    getItemName: (item) =>
                        "${item.firstName} ${item.lastName}", // غيّر حسب الحقل المناسب في UsersModel
                    getItemId: (item) =>
                        item.id, // غيّر حسب الحقل المناسب في UsersModel
                    onSelected: (selectedUser) {
                      print("Selected user: ${selectedUser.name}");
                      // هنا خزّن الـ id أو أي بيانات تريد
                      controller.selectedUserId = selectedUser.original.id!;
                    },
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
                      controller.getSubjects(selectedGrade.original.id!);
                    },
                  ),
                  controller.gradeIdController.text.isNotEmpty
                      ? CustomGenericDropDown<SubjectsModel>(
                          title: "Subject",
                          listdata: controller.subjectList,
                          dropdownSelectedName:
                              controller.subjectNameController,
                          dropdownSelectedID: controller.subjectIdController,
                          getItemName: (item) => item.name!,
                          getItemId: (item) => item.id,
                          onSelected: (selectedSubject) {
                            // إذا حبيت تعمل شي بعد اختيار المادة
                          },
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.snackbar(
                              "تنبيه",
                              "يرجى اختيار الصف أولاً قبل اختيار المادة",
                              backgroundColor: Colors.orangeAccent,
                              colorText: Colors.white,
                            );
                          },
                          child: AbsorbPointer(
                            absorbing: true, // يمنع التفاعل
                            child: CustomGenericDropDown<SubjectsModel>(
                              title: "Subject",
                              listdata: const [], // فاضي مؤقتاً
                              dropdownSelectedName:
                                  controller.subjectNameController,
                              dropdownSelectedID:
                                  controller.subjectIdController,
                              getItemName: (item) => item.name ?? "",
                              getItemId: (item) => item.id,
                            ),
                          ),
                        ),

                  // GetBuilder<AddStudentsController>(
                  //   id: "sectionsDropdown",
                  //   builder: (controller) {
                  //     return CustomGenericDropDown<SectionsModel>(
                  //       title: "Sections",
                  //       listdata: controller.sectionsList,
                  //       dropdownSelectedName: controller.sectionNameController,
                  //       dropdownSelectedID: controller.sectionIdController,
                  //       getItemName: (item) => item.name!,
                  //       getItemId: (item) => item.id,
                  //     );
                  //   },
                  // ),
                  CustomButton(
                    onPressedUpload: () {
                      controller.addTeacher();
                    },
                    buttontitle: "Add Teacher",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
