import 'package:sqflite/sqflite.dart' as sql;
import '../model/anime_model.dart';

class SqlHelper {
  static Future<void> createTable(sql.Database database) async {
    database.execute("""
      CREATE TABLE animes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        name TEXT NOT NULL,
        desc TEXT NOT NULL,
        type TEXT NOT NULL,
        image TEXT NOT NULL
       )
      """
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
        "animes.db",
        version: 2,
        onCreate: (database, version) async {
          return createTable(database);
        }
    );
  }
  static Future<void> saveSign(Anime anime) async {
    final db = await SqlHelper.db();
    await db.insert('animes', anime.toJson());
  }
  static Future<List<Anime>> getAllSigns() async {
    final db = await SqlHelper.db();
    final maps = await db.query('animes');
    return maps.map((e) => Anime.fromJson(e)).toList();
  }
  static Future<void> deleteSign(int? id) async {
    final db = await SqlHelper.db();
    await db.delete('animes', where: "id = ?", whereArgs: [id]);
  }
  static Future<void> updateSign(int? id, Anime anime) async {
    final db = await SqlHelper.db();
    await db.update("animes", anime.toJson(), where: "id = ?", whereArgs: [id]);
  }
  static Future<void> clear() async {
    final db = await SqlHelper.db();
    await db.query("DELETE FROM animes");
  }
}
