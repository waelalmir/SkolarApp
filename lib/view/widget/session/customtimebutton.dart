import 'package:flutter/material.dart';
import 'package:skolar/core/constant/color.dart';

class CustomTimeButton extends StatelessWidget {
  final TimeOfDay selectedTime; // الوقت الحالي المختار
  final void Function(TimeOfDay)
  onTimeSelected; // دالة التحديث عند اختيار وقت جديد
  final Widget? widget;
  const CustomTimeButton({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () async {
          // فتح الـ Time Picker
          TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    tertiary: AppColor.lightGold,
                    primary: AppColor.primaryColor, // لون زر التأكيد
                    onPrimary: Colors.white, // لون النص داخل زر التأكيد
                    surface: Colors.white, // خلفية نافذة الاختيار
                    onSurface: AppColor.seconderyColor, // لون النصوص داخل الوقت
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColor.primaryColor, // أزرار Cancel/OK
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );

          // إذا اختار المستخدم وقت جديد
          if (picked != null) {
            onTimeSelected(picked);
          }
        },
        // style: ButtonStyle(
        //   backgroundColor: WidgetStatePropertyAll(AppColor.seconderyColor),
        //   shape: WidgetStatePropertyAll(
        //     RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //       side: BorderSide(color: AppColor.primaryColor, width: 2.0),
        //     ),
        //   ),
        // ),
        child: widget,
        // Text(title, style: TextStyle(color: AppColor.seconderyColor))
      ),
    );
  }
}
