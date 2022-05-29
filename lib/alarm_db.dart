import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Alarm {
  String label;
  List<String> days;

  Alarm({required this.label, required this.days});

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'days': days,
    };
  }

  @override
  String toString() {
    return 'Alarm{label: $label, days: $days}';
  }
}

class AlarmDB {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'alarm_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE ALARM_TB(LABEL_PK TEXT PRIMARY KEY, DAYS TEXT)");
      },
      version: 1,
    );
    return _db;
  }

  // 데이터베이스 CRUD
  // Create
  Future<void> insertAlarm(Alarm alarm) async {
    final db = await database;

    await db.insert(
      'ALARM_TB',
      alarm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<List<Alarm>> read() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('ALARM_TB');

    return List.generate(maps.length, (i) {
      return Alarm(
        label: maps[i]['LABEL_PK'],
        days: maps[i]['DAYS'],
      );
    });
  }

  // Update
  Future<void> updateAlarm(Alarm alarm) async {
    final db = await database;

    await db.update(
      'ALARM_TB',
      alarm.toMap(),
      where: "LABEL_PK = ?",
      whereArgs: [alarm.label],
    );
  }

  // Delete
  Future<void> deleteAlarm(String label) async {
    final db = await database;

    await db.delete(
      'ALARM_TB',
      where: "LABEL_PK = ?",
      whereArgs: [label],
    );
  }
}
