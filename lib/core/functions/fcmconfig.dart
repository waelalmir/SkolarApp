// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';

// requestPermissionNotification() async {
//   // ignore: unused_local_variable
//   NotificationSettings settings =
//       await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
// }

// fcmconfig() {
//   FirebaseMessaging.onMessage.listen((message) {
//     print("noti=====================================");
//     print(message.notification!.title);
//     print(message.notification!.body);
//     Get.snackbar(message.notification!.title!, message.notification!.body!);
//   });
// }
