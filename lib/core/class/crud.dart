import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:skolar/core/class/statusrequest.dart';
import '../functions/checkinternet.dart';

// 🔒 معلومات المصادقة الأساسية
const String _apiUsername = "wael";
const String _apiPassword = "wael12345";

class Crud {
  // إنشاء الـ Basic Auth Header
  static String _basicAuth = 'Basic ' + base64Encode(utf8.encode('$_apiUsername:$_apiPassword'));

  // =========================================================
  // 1️⃣ دالة POST العادية (بدون ملفات)
  // =========================================================
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkurl),
          headers: {
            'authorization': _basicAuth,
          },
          body: data,
        );

        print("📡 URL: $linkurl");
        print("📤 Sent Body: $data");
        print("🔐 Auth: $_basicAuth");
        print("📥 StatusCode: ${response.statusCode}");
        print("🧾 Raw Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print("❌ Error in postData: $e");
      return const Left(StatusRequest.serverfailure);
    }
  }

  // =========================================================
  // 2️⃣ دالة POST مع رفع ملفات (Multipart)
  // =========================================================
  Future<Either<StatusRequest, Map>> postDataWithFile(
      String linkurl, Map data, File file, String fileField) async {
    try {
      if (await checkInternet()) {
        // إنشاء طلب Multipart
        var request = http.MultipartRequest("POST", Uri.parse(linkurl));

        // 🧩 إضافة الـ Authorization Header
        request.headers['authorization'] = _basicAuth;

        // إضافة الملف
        var multipartFile = await http.MultipartFile.fromPath(
          fileField,
          file.path,
        );
        request.files.add(multipartFile);

        // إضافة البيانات النصية
        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        // إرسال الطلب
        var streamedResponse = await request.send();

        // قراءة الاستجابة
        var response = await http.Response.fromStream(streamedResponse);

        print("📡 URL: $linkurl");
        print("📤 Fields: $data");
        print("📎 File Field: $fileField");
        print("🔐 Auth: $_basicAuth");
        print("📥 StatusCode: ${response.statusCode}");
        print("🧾 Raw Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print("❌ Error in postDataWithFile: $e");
      return const Left(StatusRequest.serverfailure);
    }
  }
}
