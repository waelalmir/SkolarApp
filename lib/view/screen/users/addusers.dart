import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/addusers_controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/functions/validinput.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/core/shared/custombutton.dart';
import 'package:skolar/core/shared/customdropdaown.dart';
import 'package:skolar/core/shared/customtextform.dart';

class Addusers extends StatelessWidget {
  const Addusers({super.key});

  @override
  Widget build(BuildContext context) {
    // AddusersController controller =
    Get.put(AddusersController());
    return Scaffold(
      appBar: Customappbar(title: "Add user"),
      body: GetBuilder<AddusersController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formstate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextForm(
                          hintText: "please Enter the first name",
                          labelText: "First Name",
                          myController: controller.firstName,
                          valid: (val) {
                            return validinput(val!, 2, 100, "");
                          },
                          isNumber: false,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextForm(
                          hintText: "please Enter the last name",
                          labelText: "Last Name",
                          myController: controller.lastName,
                          valid: (val) {
                            return validinput(val!, 2, 100, "");
                          },
                          isNumber: false,
                        ),
                      ),
                    ],
                  ),
                  CustomTextForm(
                    hintText: "please Enter user Email",
                    labelText: "Email",
                    myController: controller.email,
                    valid: (val) {
                      return validinput(val!, 5, 100, "email");
                    },
                    isNumber: false,
                  ),
                  CustomTextForm(
                    hintText: "please Enter user Phone number",
                    labelText: "phone",
                    myController: controller.phone,
                    valid: (val) {
                      return validinput(val!, 5, 100, "phone");
                    },
                    isNumber: true,
                  ),
                  CustomTextForm(
                    hintText: "please Enter user password",
                    labelText: "Password",
                    myController: controller.password,
                    valid: (val) {
                      return validinput(val!, 8, 100, "");
                    },
                    isNumber: false,
                  ),
                  CustomDropDown(
                    title: "Roles",
                    listdata: controller.rolesList,
                    dropdownSelectedID: controller.roleIdController,
                    dropdownSelectedName: controller.roleNameController,
                  ),
                  CustomButton(
                    onPressedUpload: () {
                      controller.addUser();
                    },
                    buttontitle: "Add User",
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
