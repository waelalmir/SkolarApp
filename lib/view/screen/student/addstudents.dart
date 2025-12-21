import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/students/addstudents_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/functions/validinput.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/core/shared/customtextform.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/data/model/sections_model.dart';
import 'package:skolar/data/model/users_model.dart';
import 'package:skolar/view/widget/student/customgradedropdown.dart';

class Addstudents extends StatelessWidget {
  const Addstudents({super.key});

  @override
  Widget build(BuildContext context) {
    // AddusersController controller =
    Get.put(AddStudentsController());
    return Scaffold(
      appBar: Customappbar(title: "Add Students"),
      body: GetBuilder<AddStudentsController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formstate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView(
                children: [
                  CustomTextForm(
                    hintText: "please set date of birth",
                    labelText: "date of birth",
                    isNumber: false,
                    valid: (val) {
                      return validinput(val!, 2, 100, "");
                    },
                    myController: controller.dateController,
                    isdropdown: true,
                    onTap: () async {
                      controller.dobSelect(context);
                    },
                  ),
                  CustomGenericDropDown<UsersModel>(
                    title: "Users",
                    listdata: controller.usersList,
                    dropdownSelectedName: controller.dropdownSelectedName,
                    dropdownSelectedID: controller.dropdownSelectedID,
                    getItemName: (item) => "${item.firstName} ${item.lastName}",
                    getItemId: (item) => item.id,
                    onSelected: (selectedUser) {
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
                      controller.getSections(selectedGrade.original.id!);
                    },
                  ),
                  GetBuilder<AddStudentsController>(
                    id: "sectionsDropdown",
                    builder: (controller) {
                      return CustomGenericDropDown<SectionsModel>(
                        title: "Sections",
                        listdata: controller.sectionsList,
                        dropdownSelectedName: controller.sectionNameController,
                        dropdownSelectedID: controller.sectionIdController,
                        getItemName: (item) => item.name!,
                        getItemId: (item) => item.id,
                      );
                    },
                  ),

                  CustomButton(
                    onPressedUpload: () {
                      controller.addStudent();
                    },
                    buttontitle: "Add Student",
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
