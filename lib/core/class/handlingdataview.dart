// core/class/handlingdataview.dart

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skolar/core/class/statusrequest.dart';

import '../constant/lottieasset.dart';

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  // 💡 الخاصية الجديدة لدعم الـ CustomScrollView
  final bool isSliver;

  const HandlingDataRequest({
    super.key,
    required this.statusRequest,
    required this.widget,
    this.isSliver = false, // القيمة الافتراضية خاطئة
  });

  // 💡 دالة مساعدة لتغليف المحتوى بـ SliverToBoxAdapter إذا لزم الأمر
  Widget _wrapInSliver(Widget content) {
    if (isSliver) {
      // إذا كنا في سياق Sliver، نغلف المحتوى بـ SliverToBoxAdapter
      return SliverToBoxAdapter(child: content);
    }
    // إذا لم نكن في سياق Sliver، نعيد المحتوى كما هو
    return content;
  }

  @override
  Widget build(BuildContext context) {
    switch (statusRequest) {
      case StatusRequest.loading:
        // نستخدم الدالة المساعدة _wrapInSliver لتغليف الـ Center
        return _wrapInSliver(
          Center(
            child: Lottie.asset(
              AppLottieAsset.lottieloading,
              width: 250,
              height: 250,
            ),
          ),
        );

      case StatusRequest.offlinefailure:
        return _wrapInSliver(
          Center(
            child: Lottie.asset(
              AppLottieAsset.lottieoffline,
              width: 250,
              height: 250,
            ),
          ),
        );

      case StatusRequest.serverfailure:
        return _wrapInSliver(
          Center(
            child: Lottie.asset(
              AppLottieAsset.lottieerror,
              width: 250,
              height: 250,
            ),
          ),
        );

      case StatusRequest.nodata:
        return _wrapInSliver(
          const Center(child: Text("لا توجد بيانات (No Data)")),
        );

      case StatusRequest.failure:
        // حالة الفشل المنطقي (مثل كلمة مرور خطأ)
        // نعرض الويدجت الرئيسي (لا حاجة للتغليف بـ SliverToBoxAdapter)
        return widget;

      case StatusRequest.success:
      case StatusRequest.none:
      // ignore: unreachable_switch_default
      default:
        // في حالة النجاح أو الحالة الابتدائية:
        if (isSliver) {
          // ⚠️ إذا كان isSliver صحيحاً، يجب أن يكون الـ widget المُمرَّر هو Sliver (مثل SliverGrid.builder)
          return widget;
        }
        // وإلا، نعرض الويدجت الرئيسي كـ Box Widget عادي
        return widget;
    }
  }
}
