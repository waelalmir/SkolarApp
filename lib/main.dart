import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'binding/initialbinding.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/sevices.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());

    return ScreenUtilInit(
      designSize: const Size(360, 690), // حجم التصميم الأساسي (هاتف متوسط)
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          translations: MyTranslation(),
          debugShowCheckedModeBanner: false,
          title: 'Skolar App',
          locale: controller.language,
          theme: controller.appTheme,
          initialBinding: InitialBindings(),
          getPages: routes,
        );
      },
    );
  }
}
