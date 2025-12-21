import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skolar/core/services/firebase_messaging_service.dart';
import 'package:skolar/core/services/local_notifications_service.dart';
import 'package:skolar/core/services/firebase_options.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPrefrences;
  Future<MyServices> init() async {
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final localNotificationsService = LocalNotificationsService.instance();
    await localNotificationsService.init();

    final firebaseMessagingService = FirebaseMessagingService.instance();
    await firebaseMessagingService.init(
      localNotificationsService: localNotificationsService,
    );

    sharedPrefrences = await SharedPreferences.getInstance();

    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
