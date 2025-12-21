import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/students/studentsdetails.dart';
import 'package:skolar/core/functions/responsive.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/view/widget/home/customsectioncard.dart';

class Studentdetails extends StatelessWidget {
  const Studentdetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive(context);
    StudentsdetailsController controller = Get.put(StudentsdetailsController());
    return Scaffold(
      appBar: Customappbar(title: "Student Details"),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: GridView.builder(
          itemCount: controller.items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: r.crossaxisCount(),
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final item = controller.items[index];

            return TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 300 + (index * 80)),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
                );
              },
              child: CustomSectionCard(
                onTap: item['onTap'],
                title: item['title'],
                icon: item['icon'],
              ),
            );
          },
        ),
      ),
    );
  }
}
