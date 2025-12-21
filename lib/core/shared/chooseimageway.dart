import 'package:flutter/material.dart'; // نحتاج هذه المكتبة للـ Container، Colors، ElevatedButton، إلخ.
import 'package:get/get.dart'; // مكتبة GetX

class ChooseImageWay extends StatelessWidget {
  final void Function()? onTapCamera;
  final void Function()? onTapStudio;
  const ChooseImageWay({super.key, this.onTapCamera, this.onTapStudio});

  // ⭐️ دالة منفصلة لعرض BottomSheet
  void _showImageOptionsBottomSheet() {
    Get.bottomSheet(
      // الـ Container هو الودجت الذي سيتم عرضه كنافذة منبثقة
      Container(
        padding: const EdgeInsets.all(20),
        // يمكن تحديد ارتفاع ديناميكي أو ثابت
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          // هذه تجعل الـ Column يأخذ فقط المساحة اللازمة للمحتوى
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "اختر طريقة رفع الصورة",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // زر لاختيار من الكاميرا
            InkWell(
              onTap: onTapCamera,
              child: ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('الكاميرا'),
                onTap: () {
                  // TODO: أضف هنا وظيفة التقاط صورة من الكاميرا
                  Get.back();
                  Future.microtask(() => onTapCamera?.call()); // إغلاق النافذة
                },
              ),
            ),
            // زر لاختيار من المعرض
            InkWell(
              onTap: onTapStudio,
              child: ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('معرض الصور'),
                onTap: () {
                  // TODO: أضف هنا وظيفة اختيار صورة من المعرض
                  Get.back();
                  Future.microtask(() => onTapStudio?.call());
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ⭐️ دالة build الآن تُرجع ودجت واحد (زر)
    return Center(
      child: ElevatedButton.icon(
        onPressed: _showImageOptionsBottomSheet, // 👈 استدعاء الدالة عند النقر
        icon: const Icon(Icons.image),
        label: const Text("اختر صورة"),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
