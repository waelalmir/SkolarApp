import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skolar/controller/f/home_controller.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/core/functions/responsive.dart';
import 'package:skolar/core/shared/customappbar.dart';
import 'package:skolar/view/widget/home/customsectioncard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final Responsive r = Responsive(context);

    return Scaffold(
      appBar: Customappbar(
        title: "Home",
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: GridView.builder(
          itemCount: _items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: r.crossaxisCount(),
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final item = _items[index];

            return TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 300 + (index * 80)),
              curve: Curves.easeOutCubic,

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

final List<Map<String, dynamic>> _items = [
  {
    "title": "Add user",
    "icon": Icons.person_add,
    "onTap": () => Get.toNamed(AppRoutes.addUser),
  },
  {
    "title": "Users",
    "icon": Icons.person,
    "onTap": () => Get.toNamed(AppRoutes.users),
  },
  {
    "title": "Classes",
    "icon": Icons.house_outlined,
    "onTap": () => Get.toNamed(AppRoutes.viewgrades),
  },
  {
    "title": "Add Students",
    "icon": Icons.person_4_sharp,
    "onTap": () => Get.toNamed(AppRoutes.addstudents),
  },
  {
    "title": "Add Subjects",
    "icon": Icons.science_rounded,
    "onTap": () => Get.toNamed(AppRoutes.addsubjects),
  },
  {
    "title": "Add Session",
    "icon": Icons.more_time_rounded,
    "onTap": () => Get.toNamed(AppRoutes.addsession),
  },
  {
    "title": "View Teachers",
    "icon": Icons.groups_2_outlined,
    "onTap": () => Get.toNamed(AppRoutes.viewteachers),
  },
  {
    "title": "Add Teachers",
    "icon": Icons.group_add_sharp,
    "onTap": () => Get.toNamed(AppRoutes.addteachers),
  },
  {
    "title": "View Exams",
    "icon": Icons.picture_as_pdf_rounded,
    "onTap": () => Get.toNamed(AppRoutes.viewexam),
  },
  {
    "title": "Add Exams",
    "icon": Icons.file_copy_sharp,
    "onTap": () => Get.toNamed(AppRoutes.addexam),
  },
  {
    "title": "Add Mark",
    "icon": Icons.workspace_premium_outlined,
    "onTap": () => Get.toNamed(AppRoutes.addmark),
  },
];
