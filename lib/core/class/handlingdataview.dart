// core/class/handlingdataview.dart

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skolar/core/class/statusrequest.dart';

import '../constant/lottieasset.dart';

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final bool isSliver;

  const HandlingDataRequest({
    super.key,
    required this.statusRequest,
    required this.widget,
    this.isSliver = false, 
  });

  Widget _wrapInSliver(Widget content) {
    if (isSliver) {
      return SliverToBoxAdapter(child: content);
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    switch (statusRequest) {
      case StatusRequest.loading:
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
        return widget;

      case StatusRequest.success:
      case StatusRequest.none:
      default:
        if (isSliver) {
          return widget;
        }
        return widget;
    }
  }
}
