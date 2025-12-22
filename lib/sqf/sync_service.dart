import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:skolar/sqf/sqldb.dart';
import 'package:skolar/data/datasource/remote/users_data.dart';

class SyncService extends GetxService {
  late StreamSubscription _connectivitySubscription;
  final SqlDb sqlDb = SqlDb();

  @override
  void onInit() {
    super.onInit();

    print("🔵 SyncService INIT");

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      status,
    ) async {
      print("🔵 Connectivity Changed: $status");

      if (status != ConnectivityResult.none) {
        print("🟢 Internet Restored → Running Sync");
        await syncPendingRequests();
      }
    });
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> syncPendingRequests() async {
    print("🔵 SYNC START");

    final SqlDb sqlDb = SqlDb();
    final requests = await sqlDb.getAllRequests();
    print("📌 Local Pending Requests: $requests");
    print("🟡 Pending requests count: ${requests.length}");

    if (requests.isEmpty) {
      print("🔵 SYNC END (nothing to sync)");
      return;
    }

    final usersData = UsersData(Get.find());

    for (var req in requests) {
      final int id = req['id'];
      final String url = req['url'];
      final Map<String, dynamic> body = Map<String, dynamic>.from(
        jsonDecode(req['data']),
      );

      print("———————————");
      print("🔵 SYNC LOOP → ID: $id");
      print("🌐 URL: $url");
      print("📦 DATA: $body");

      try {
        final Map<String, dynamic>? response = await usersData.sendRequest(
          url,
          body,
        );

        print("📥 RESPONSE: $response");

        if (response != null && response['status'] == 'success') {
          await sqlDb.deleteRequest(id);
          print("🟢 SYNC OK → Deleted local id $id");
          continue;
        }

        if (response != null &&
            (response['message']?.toString().toLowerCase().contains(
                      'duplicate',
                    ) ==
                    true ||
                response['message']?.toString().toLowerCase().contains(
                      'exists',
                    ) ==
                    true)) {
          await sqlDb.deleteRequest(id);
          print(
            "🟠 SYNC -> Server says duplicate/exist → Deleted local id $id",
          );
          continue;
        }

        print(
          "🔴 SYNC FAILED (server rejected or null) for id $id — keeping locally",
        );
      } catch (e, st) {
        print("❌ SYNC ERROR for id $id → $e");
        print(st);
      }
    }

    print("🔵 SYNC END");
  }
}
