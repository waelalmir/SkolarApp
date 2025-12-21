import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/functions/validinput.dart';
import 'package:skolar/core/shared/customtextform.dart';

class CustomGenericDropDown<T> extends StatefulWidget {
  final bool isavailable;
  final String title;
  final String? alertext;
  final List<T> listdata;
  final TextEditingController dropdownSelectedName;
  final TextEditingController dropdownSelectedID;
  final void Function(GenericItem<T>)? onSelected;

  final String Function(T) getItemName;
  final dynamic Function(T) getItemId;

  const CustomGenericDropDown({
    super.key,
    required this.title,
    required this.listdata,
    required this.dropdownSelectedName,
    required this.dropdownSelectedID,
    required this.getItemName,
    required this.getItemId,
    this.onSelected,
    this.isavailable = true,
    this.alertext,
  });

  @override
  State<CustomGenericDropDown<T>> createState() =>
      _CustomGenericDropDownState<T>();
}

class _CustomGenericDropDownState<T> extends State<CustomGenericDropDown<T>> {
  // ignore: unused_field
  bool _showErrorBorder = false;
  @override
  Widget build(BuildContext context) {
    return CustomTextForm(
      isdropdown: true,
      hintText: widget.dropdownSelectedName.text.isEmpty
          ? widget.title
          : widget.dropdownSelectedName.text,
      labelText: widget.title,
      myController: widget.dropdownSelectedName,
      valid: (val) => validinput(val!, 0, 100, ""),
      isNumber: false,
      onTap: () {
        // FocusScope.of(context).unfocus();
        // showDropdown();
        // الشرط الجديد
        if (!widget.isavailable) {
          // 1. تفعيل البوردر الأحمر
          setState(() {
            _showErrorBorder = true;
          });

          // 2. إظهار السناك بار
          Get.snackbar(
            "Alert",
            widget.alertext!,
            backgroundColor: AppColor.primaryColor,
            colorText: Colors.white,
          );

          // 3. (اختياري) إزالة البوردر الأحمر تلقائياً بعد اختفاء السناك بار
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _showErrorBorder = false;
              });
            }
          });

          return; // إيقاف التنفيذ وعدم فتح القائمة
        }

        // إذا كان متاحاً (الوضع الطبيعي)
        FocusScope.of(context).unfocus();
        showDropdown();
      },
    );
  }

  void showDropdown() {
    final convertedList = widget.listdata.map((item) {
      return SelectedListItem(
        data: GenericItem(
          name: widget.getItemName(item), // الاسم اللي يظهر
          id: widget.getItemId(item), // الـ ID
          original: item, // العنصر الأصلي
        ),
      );
    }).toList();

    DropDownState(
      dropDown: DropDown(
        data: convertedList,
        submitButtonText: "Save",
        clearButtonText: "Clear",
        bottomSheetTitle: Text(widget.title),
        enableMultipleSelection: false,
        onSelected: (selectedList) {
          // نحصل على العنصر كـ GenericItem<dynamic>
          final selectedDynamic =
              selectedList.first.data as GenericItem<dynamic>;

          // تحديث الـ textControllers
          widget.dropdownSelectedName.text = selectedDynamic.name;
          widget.dropdownSelectedID.text = selectedDynamic.id.toString();

          // استدعاء الدالة المرسلة، نرسل العنصر الأصلي بدل cast لـ <T>
          if (widget.onSelected != null) {
            widget.onSelected!(
              GenericItem<T>(
                name: selectedDynamic.name,
                id: selectedDynamic.id,
                original: selectedDynamic.original as T,
              ),
            );
          }
        },
      ),
    ).showModal(context);
  }
}

class GenericItem<T> {
  final String name;
  final dynamic id;
  final T original;

  GenericItem({required this.name, required this.id, required this.original});
  @override
  String toString() {
    return name; // هذا هو المهم
  }
}
