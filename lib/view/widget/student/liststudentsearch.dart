import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/searchmixcontroller.dart';
import 'package:skolar/core/constant/routes.dart';
import 'package:skolar/data/model/studentmodel.dart';
import 'package:skolar/view/widget/users/customcardusers.dart';

class Liststudentsearch extends StatelessWidget {
  final List<StudentsModel> listData;
  Liststudentsearch({super.key, required this.listData});
  final SearchMixController controller = Get.put(SearchMixController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.builder(
          itemCount: listData.length,
          padding: const EdgeInsets.all(12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final model = listData[index];
            return InkWell(
              onTap: () {
                print(model.studentId);
                Get.toNamed(
                  AppRoutes.studentdetails,
                  arguments: {"studentid": model.studentId},
                );
              },
              child: Customcardusers(
                name: "${model.firstName} ${model.lastName} ",
                email: model.enrollmentDate!,
                id: model.studentCode.toString(),
                number: model.phone!,
              ),
            );
          },
        );
      },
    );
  }
}
