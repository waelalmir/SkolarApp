import 'package:file_picker/file_picker.dart';
import 'dart:io';

// Future<File?> fileUploadcamera() async {
//   // 1. إنشاء مثيل (Instance) لـ ImagePicker
//   final ImagePicker picker = ImagePicker();

//   // 2. استخدام دالة pickImage لالتقاط الصورة من الكاميرا
//   // pickImage ترجع XFile? (وهو الملف المُلتقط) أو null إذا ألغى المستخدم العملية.
//   final XFile? xFile = await picker.pickImage(
//     source: ImageSource.camera,
//   );

//   // 3. التحقق مما إذا تم التقاط ملف
//   if (xFile != null) {
//     // 4. تحويل XFile إلى كائن File لإرجاعه (أكثر شيوعاً للاستخدامات اللاحقة في Flutter)
//     // يمكنك تعديل هذا حسب حاجتك، فـ XFile نفسه كافٍ في كثير من الحالات
//     return File(xFile.path);
//   } else {
//     // 5. إرجاع null إذا لم يتم اختيار أي ملف
//     return null;
//   }
// }

// fileUploadgallery([bool isSvg = false]) async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: isSvg
//           ? ["svg", "SVG"]
//           : [
//               "png",
//               "jpg",
//               "jpeg",
//               "PNG",
//               "JPG",
//               "JPEG",
//               "gif",
//             ]);
//   if (result != null) {
//     return result.files.single.path;
//   } else {
//     return null;
//   }
// }
Future<File?> fileUploadgallery([bool isSvg = false]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: isSvg
        ? ["svg", "SVG"]
        : ["png", "jpg", "jpeg", "PNG", "JPG", "JPEG", "gif"],
  );

  if (result != null) {
    String? filePath = result.files.single.path;
    if (filePath != null) {
      // ⬅️ يتم إنشاء كائن File من المسار النصي وإرجاعه
      return File(filePath);
    }
  }
  // إذا لم يتم اختيار ملف أو كان المسار null، يتم إرجاع null
  return null;
}
