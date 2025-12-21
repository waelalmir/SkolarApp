import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  // ===================== DB INIT =====================
  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'skolar.db');

    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );

    return mydb; // ⚠️ لازم ترجع الـ DB
  }

  _onUpgrade(Database db, int oldVersion, int newVresion) {
    print("On Upgrade ===============================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE pending_request (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      url TEXT NOT NULL,
      data TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE cache_table (
      key TEXT PRIMARY KEY,
      data TEXT,
      updated_at TEXT
    )
  ''');

    print("CREATE DATABASE AND TABLE ==============================");
  }

  // ===================== RAW GENERIC =====================
  readData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawQuery(sql);
  }

  insertData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawInsert(sql);
  }

  updateData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawUpdate(sql);
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawDelete(sql);
  }

  Future<void> savecache(String key, dynamic data) async {
    Database? dbClient = await db;
    await dbClient!.insert("cache_table", {
      "key": key,
      "data": jsonEncode(data),
      "updated_at": DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List> getCache(String key) async {
    Database? dbClient = await db;
    var result = await dbClient!.query(
      "cache_table",
      where: "key = ?",
      whereArgs: [key],
    );

    if (result.isNotEmpty) {
      return jsonDecode(result.first["data"] as String);
    }
    return [];
  }

  Future<List<T>> fetchAndCache<T>({
    required String cacheKey,
    required Future<Map<String, dynamic>> Function() apiCall,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    Database? mydb = await db;

    // حاول تجيب الكاش
    final cache = await mydb!.query(
      "cache_table",
      where: "key = ?",
      whereArgs: [cacheKey],
    );

    if (cache.isNotEmpty) {
      final data = cache.first["data"] as String;
      final decoded = List<Map<String, dynamic>>.from(jsonDecode(data));
      print("📦 Loaded from cache: $cacheKey");
      print("📌 Cached Raw Data: $decoded");
      return decoded.map((e) => fromJson(e)).toList();
    }

    // الكاش فارغ → نجيب من السيرفر
    print("🌐 Cache empty → calling API for $cacheKey");
    final response = await apiCall();
    print("🌐 API Response: $response");

    if (response["data"] != null) {
      List list = response["data"];
      print("💾 Saving To Cache: $list");

      // خزّن بالكاش
      await mydb.insert("cache_table", {
        "key": cacheKey,
        "data": jsonEncode(list),
        "updated_at": DateTime.now().toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
      print("💾 Saved To Cache Successfully");

      return list.map((e) => fromJson(e)).toList();
    }

    return [];
  }

  Future<List<T>> fetchCacheOnly<T>({
    required String cacheKey,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    Database? mydb = await db;

    final cache = await mydb!.query(
      "cache_table",
      where: "key = ?",
      whereArgs: [cacheKey],
    );

    if (cache.isNotEmpty) {
      final data = cache.first["data"] as String;
      final decoded = List<Map<String, dynamic>>.from(jsonDecode(data));

      print("📦 Loaded from cache: $cacheKey");
      print("📌 Cached Raw Data: $decoded");

      return decoded.map((e) => fromJson(e)).toList();
    }

    print("⚠️ No cache found for $cacheKey");
    return [];
  }

  Future<void> saveCache({required String key, required List data}) async {
    Database? mydb = await db;

    await mydb!.insert("cache_table", {
      "key": key,
      "data": jsonEncode(data),
      "updated_at": DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // ===================== READY FUNCTIONS =====================

  /// 🟦 إضافة طلب بدون SQL
  Future<int> insertRequest(String url, Map<String, dynamic> data) async {
    Database? mydb = await db;

    return await mydb!.insert("pending_request", {
      "url": url,
      "data": jsonEncode(data),
    });
  }

  /// 🟨 جلب كل الطلبات بدون SQL
  Future<List<Map<String, dynamic>>> getAllRequests() async {
    Database? mydb = await db;
    return await mydb!.query("pending_request");
  }

  /// 🟥 حذف طلب حسب ID بدون SQL
  Future<int> deleteRequest(int id) async {
    Database? mydb = await db;
    return await mydb!.delete(
      "pending_request",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
