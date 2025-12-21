import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/subjects/addsubjects_controller.dart';
import 'package:skolar/core/functions/validinput.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/core/shared/customtextform.dart';
import 'package:skolar/data/model/grade_model.dart';
import 'package:skolar/view/widget/student/customgradedropdown.dart';

class Addsubjects extends StatelessWidget {
  const Addsubjects({super.key});

  @override
  Widget build(BuildContext context) {
    AddsubjectsController controller = Get.put(AddsubjectsController());
    return Scaffold(
      appBar: Customappbar(title: "Add Subjects"),
      body: Form(
        key: controller.formstate,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomTextForm(
                hintText: "Name of subject",
                labelText: "Name",
                myController: controller.name,
                valid: (val) {
                  return validinput(val!, 2, 100, "");
                },
                isNumber: false,
              ),
              CustomGenericDropDown<GradeModel>(
                title: "Grades",
                listdata: controller.data,
                dropdownSelectedName: controller.gradeNameController,
                dropdownSelectedID: controller.gradeIdController,
                getItemName: (item) => "${item.name} ${item.description}",
                getItemId: (item) => item.id,
                onSelected: (selectedGrade) {
                  controller.gradeid = selectedGrade.original.id!;
                },
              ),
              CustomButton(
                onPressedUpload: () => controller.addSubject(),
                buttontitle: "Add subject",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
