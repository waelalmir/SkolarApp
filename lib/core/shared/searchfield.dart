import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/core/constant/color.dart';

class SearchField extends StatelessWidget {
  final Color? fillColor;
  final IconData? preicon;
  final Color? iconColor;
  final void Function(String)? onChanged;
  final TextEditingController? mycontroller;
  final void Function()? onPressedsearch;
  final Function(String)? onFieldSubmitted;
  final void Function()? notificationpress;
  const SearchField({
    super.key,
    this.fillColor,
    this.preicon,
    this.iconColor,
    this.mycontroller,
    this.onChanged,
    this.onPressedsearch,
    this.notificationpress,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.primaryColor),
                  gradient: LinearGradient(
                    colors: [
                      AppColor.lightGold.withValues(alpha: 1),
                      AppColor.lightGold.withValues(alpha: 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: fillColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: notificationpress,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primaryColor),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    AppColor.lightGold.withValues(alpha: 1),
                    AppColor.lightGold.withValues(alpha: 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: TextFormField(
                onFieldSubmitted: onFieldSubmitted,
                controller: mycontroller,
                onChanged: onChanged,
                style: const TextStyle(color: AppColor.seconderyColor),
                cursorColor: AppColor.primaryColor,
                decoration: InputDecoration(
                  filled: false,
                  fillColor: fillColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(preicon, color: AppColor.primaryColor),
                    onPressed: onPressedsearch,
                    color: iconColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
