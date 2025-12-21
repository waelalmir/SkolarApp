import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/mark/add_mark_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/functions/validinput.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/core/shared/customtextform.dart';
import 'package:skolar/data/model/exam_model.dart';
import 'package:skolar/data/model/studentmodel.dart';
import 'package:skolar/view/widget/student/customgradedropdown.dart';

class AddMark extends StatelessWidget {
  const AddMark({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddMarkController());
    return Scaffold(
      appBar: Customappbar(title: 'Add an Mark'),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GetBuilder<AddMarkController>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    CustomGenericDropDown<StudentsModel>(
                      title: "Students",
                      listdata: controller.studentsList,
                      dropdownSelectedName: controller.studentNameController,
                      dropdownSelectedID: controller.studentIdController,
                      getItemName: (item) =>
                          "${item.firstName!} ${item.lastName!}",
                      getItemId: (item) => item.studentId,
                      onSelected: (selectedGrade) {
                        // controller.getSubjects();
                      },
                    ),
                    CustomGenericDropDown<ExamModel>(
                      title: "Exams",
                      listdata: controller.examsList,
                      dropdownSelectedName: controller.examNameController,
                      dropdownSelectedID: controller.examIdController,
                      getItemName: (item) =>
                          "${item.subjectName!} ${item.gradeName!} ",
                      getItemId: (item) => item.examId,
                      onSelected: (selectedGrade) {
                        // controller.getSubjects();
                      },
                    ),

                    CustomTextForm(
                      hintText: "Enter the mark",
                      labelText: "Mark",
                      myController: controller.mark,
                      valid: (val) {
                        return validinput(val!, 2, 5, "");
                      },
                      isNumber: true,
                    ),

                    CustomButton(
                      buttontitle: "Add mark",
                      onPressedUpload: () {
                        controller.addMark();
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
