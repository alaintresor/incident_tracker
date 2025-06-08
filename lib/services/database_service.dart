import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/incident.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'incidents.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidents(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        location TEXT NOT NULL,
        dateTime TEXT NOT NULL,
        status TEXT NOT NULL,
        photoPath TEXT
      )
    ''');
  }

  Future<int> insertIncident(Incident incident) async {
    final db = await database;
    return await db.insert('incidents', incident.toMap());
  }

  Future<List<Incident>> getAllIncidents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'incidents',
      orderBy: 'dateTime DESC',
    );

    return List.generate(maps.length, (i) {
      return Incident.fromMap(maps[i]);
    });
  }

  Future<Incident?> getIncident(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'incidents',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Incident.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateIncident(Incident incident) async {
    final db = await database;
    return await db.update(
      'incidents',
      incident.toMap(),
      where: 'id = ?',
      whereArgs: [incident.id],
    );
  }

  Future<int> deleteIncident(int id) async {
    final db = await database;
    return await db.delete(
      'incidents',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
} 