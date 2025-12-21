// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:skolar/controller/grade/viewgrades_controller.dart';
// import 'package:skolar/core/constant/color.dart';

// class DropItem extends StatelessWidget {
//   final String title;
//   final List<String> items;
//   final ViewGradesController controller;

//   const DropItem({
//     super.key,
//     required this.title,
//     required this.items,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: controller.toggle,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//             child: Text(title, style: TextStyle(color: AppColor.textcolor)),
//           ),
//         ),

//         Obx(() {
//           if (!controller.isOpen.value) return SizedBox.shrink();

//           return Container(
//             margin: const EdgeInsets.only(left: 20, top: 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: items
//                   .map(
//                     (e) => Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4),
//                       child: Text(e, style: TextStyle(color: AppColor.black)),
//                     ),
//                   )
//                   .toList(),
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }
