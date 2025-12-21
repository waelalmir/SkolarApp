// core/functions/handlingdatacontroller.dart

import 'package:skolar/core/class/statusrequest.dart';

StatusRequest handlingData(dynamic response) {
  // response يأتي من دالة الـ fold في طبقة الـ data
  // فإما أن يكون StatusRequest (في حالة الخطأ قبل الوصول للخادم)
  // أو يكون Map (في حالة النجاح والوصول للخادم)
  if (response is StatusRequest) {
    return response; // إذا كان خطأ من البداية (مثل انقطاع النت)، أرجعه مباشرة
  } else {
    // إذا وصل للخادم وأرجع بيانات، تحقق من status بداخلها
    if (response['status'] == "success") {
      return StatusRequest.success;
    } else {
      // إذا كان الـ status من الخادم هو "fail" (فشل منطقي)
      return StatusRequest.failure;
    }
  }
}
