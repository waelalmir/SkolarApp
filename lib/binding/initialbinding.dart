import 'package:get/get.dart';
import 'package:skolar/core/class/crud.dart';
import 'package:skolar/sqf/sync_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SyncService(), permanent: true); // ← مهم جداً

    Get.put(Crud());
    // Get.lazyPut(() => LoginControllerImp());
    // Get.lazyPut(() => SignUpControllerImp());
    // Get.lazyPut(() => VerifySignUpControllerImp());
  }
}
