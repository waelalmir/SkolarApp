import 'package:flutter/material.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/functions/responsive.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressedUpload;
  final String buttontitle;

  const CustomButton({
    super.key,
    this.onPressedUpload,
    required this.buttontitle,
  });

  @override
  Widget build(BuildContext context) {
    final resp = Responsive(context);

    return SizedBox(
      width: resp.width(200), // عرض الزر
      height: resp.height(50), // ارتفاع الزر
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: MaterialStatePropertyAll(AppColor.primaryColor),
        ),
        onPressed: onPressedUpload,
        child: Text(
          buttontitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: resp.font(16), // حجم الخط responsive
          ),
        ),
      ),
    );
  }
}
