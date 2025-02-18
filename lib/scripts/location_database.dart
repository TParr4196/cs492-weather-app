import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

const dbName = 'location.db';
const sqlCreateTable = 'assets/sql/create.sql';

class LocationDatabase {
  final Database _db;

  LocationDatabase({required Database db}) : _db = db;

  static Future<LocationDatabase> open() async {
    final Database db = await openDatabase(dbName, version:1,
      onCreate: (Database db, int version) async {
        String query = await rootBundle.loadString(sqlCreateTable);
        await db.execute(query);
      }
    );
    return LocationDatabase(db: db);
  }

  void close() async{
    await _db.close();
  }
}