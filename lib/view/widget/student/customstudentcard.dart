import 'package:flutter/material.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/imageasset.dart';

class Customcardstudent extends StatelessWidget {
  final String name;
  final String email;
  final String code;
  final String number;
  const Customcardstudent({
    super.key,
    required this.name,
    required this.email,
    required this.code,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Row(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: Image.asset(
                  AppImageAsset.personprofile,
                  fit: BoxFit.cover,
                  width: 80, // لازم تكون أكبر من القطر
                  height: 80,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#$code",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColor.thirdColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "name: ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColor.thirdColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(email, style: TextStyle(color: AppColor.grey)),
                      SizedBox(width: 15),
                      Text(number, style: TextStyle(color: AppColor.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
