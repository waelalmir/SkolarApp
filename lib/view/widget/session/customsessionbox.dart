import 'package:flutter/material.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/functions/responsive.dart';

class Customsessionbox extends StatelessWidget {
  final Responsive? r;
  final String title;
  final String value;
  const Customsessionbox({
    super.key,
    this.r,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(r!.padding(10)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(r!.width(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColor.grey,
                fontSize: r!.font(12),
                fontWeight: FontWeight.w600,
              ),
            ),

            Text(
              value,
              style: TextStyle(
                color: AppColor.thirdColor,
                fontSize: r!.font(15),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
