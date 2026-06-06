import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'catatan.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  DbHelper._internal();

  factory DbHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'catatan.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE catatan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT NOT NULL,
            isi TEXT NOT NULL,
            kategori INTEGER NOT NULL,
            dibuat_pada TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertCatatan(Catatan catatan) async {
    final db = await database;
    return await db.insert('catatan', catatan.toMap());
  }

  Future<List<Catatan>> getCatatan() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('catatan', orderBy: 'dibuat_pada DESC');
    return List.generate(maps.length, (i) => Catatan.fromMap(maps[i]));
  }

  Future<int> updateCatatan(Catatan catatan) async {
    final db = await database;
    return await db.update(
      'catatan',
      catatan.toMap(),
      where: 'id = ?',
      whereArgs: [catatan.id],
    );
  }

  Future<int> deleteCatatan(int id) async {
    final db = await database;
    return await db.delete(
      'catatan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
