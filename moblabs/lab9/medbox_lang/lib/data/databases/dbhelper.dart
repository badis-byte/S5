import 'dart:async';
import 'package:medbox/data/databases/db_record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class DBHelper {
  static const _database_name = "medbox.db";
  static const _database_version = 1;

  static Database? _db;

  static List<String> sql_codes = [Records.sql_code];

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), _database_name);

    _db = await openDatabase(
      path,
      version: _database_version,
      onCreate: (db, version) async {
        for (var item in sql_codes) {
          await db.execute(item);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Example: recreate all tables if version changes
        for (var item in sql_codes) {
          await db.execute(item);
        }
      },
    );

    return _db!;
  }
}
