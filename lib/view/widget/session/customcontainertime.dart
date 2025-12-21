import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/session/addsession_controller.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/view/widget/session/customtimebutton.dart';

class Customcontainertime extends GetView<AddsessionController> {
  const Customcontainertime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.lightGold,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primaryColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Start Time",
                  style: TextStyle(
                    color: AppColor.seconderyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),

                const SizedBox(height: 8),
                CustomTimeButton(
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColor.primaryColor,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.startTime.format(context),
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  selectedTime: controller.startTime,
                  onTimeSelected: (picked) {
                    controller.updateStartTime(picked);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "End Time",
                  style: TextStyle(
                    color: AppColor.seconderyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),

                const SizedBox(height: 8),
                CustomTimeButton(
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColor.primaryColor,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.endTime.format(context),
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  selectedTime: controller.endTime,
                  onTimeSelected: (picked) {
                    controller.updateEndTime(picked);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
