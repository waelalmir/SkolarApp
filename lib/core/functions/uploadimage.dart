import 'package:file_picker/file_picker.dart';
import 'dart:io';


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
      return File(filePath);
    }
  }
  return null;
}
