import 'package:skolar/core/functions/validinput.dart';
import 'package:skolar/core/shared/customtextform.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String title;
  final List<SelectedListItem<dynamic>> listdata;
  final TextEditingController dropdownSelectedName;
  final TextEditingController dropdownSelectedID;

  const CustomDropDown({
    super.key,
    required this.title,
    required this.listdata,
    required this.dropdownSelectedName,
    required this.dropdownSelectedID,
  });

  void showDropdown(BuildContext context) {
    DropDownState(
      dropDown: DropDown(
        isDismissible: true,
        bottomSheetTitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        submitButtonText: 'Done',
        clearButtonText: 'Clear',
        data: listdata,
        enableMultipleSelection: false,
        onSelected: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty) {
            final SelectedListItem item =
                selectedList.first as SelectedListItem;

            dropdownSelectedName.text = item.data.toString();

            const roleMap = {
              "Admin": "admin",
              "Principal": "principal",
              "Teacher": "teacher",
              "Student": "student",
              "Parent": "parent",
              "Staff": "staff",
            };

            dropdownSelectedID.text = roleMap[item.data.toString()] ?? "";
          }
        },
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextForm(
      isdropdown: true,
      hintText: dropdownSelectedName.text.isEmpty
          ? title
          : dropdownSelectedName.text,
      labelText: "Role",
      myController: dropdownSelectedName,
      isNumber: false,
      valid: (val) => validinput(val!, 0, 50, ""),
      onTap: () {
        FocusScope.of(context).unfocus();
        showDropdown(context);
      },

      suffixIcon: Icons.keyboard_arrow_down_rounded,
    );
  }
}
