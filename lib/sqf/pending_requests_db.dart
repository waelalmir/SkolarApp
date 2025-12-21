// import 'dart:convert';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class PendingRequestsDB {
//   PendingRequestsDB._();
//   static final PendingRequestsDB instance = PendingRequestsDB._();

//   Database? _db;

//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await _initDB();
//     return _db!;
//   }

//   Future<Database> _initDB() async {
//     final path = join(await getDatabasesPath(), 'pending_request.db');
//     return await openDatabase(
//       path,
//       version: 1, // زيد النسخة
//       onCreate: (db, version) async {
//         await db.execute('''
//         CREATE TABLE pending_request (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           url TEXT NOT NULL,
//           data TEXT NOT NULL
//         )
//       ''');
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         if (oldVersion < 2) {
//           await db.execute(
//             'ALTER TABLE pending_request ADD COLUMN url TEXT NOT NULL DEFAULT ""',
//           );
//         }
//       },
//     );
//   }

//   Future<int> insertRequest(String url, Map<String, dynamic> data) async {
//     final db = await database;
//     return await db.insert('pending_request', {
//       'url': url,
//       'data': jsonEncode(data),
//     });
//   }

//   Future<List<Map<String, dynamic>>> getAllRequests() async {
//     final db = await database;
//     return await db.query('pending_request');
//   }

//   Future<int> deleteRequest(int id) async {
//     final db = await database;
//     return await db.delete('pending_request', where: 'id = ?', whereArgs: [id]);
//   }
// }
