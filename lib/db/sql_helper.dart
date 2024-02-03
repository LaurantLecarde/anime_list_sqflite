import 'package:sqflite/sqflite.dart' as sql;
import '../model/anime_model.dart';

class SqlHelper {
  static Future<void> createTable(sql.Database database) async {
    database.execute("""
      CREATE TABLE animes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        name TEXT NOT NULL,
        episodes TEXT NOT NULL,
        type TEXT NOT NULL,
        image TEXT NOT NULL,
       )
      """
    );
    database.execute("""
      CREATE TABLE favouriteAnimes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        name TEXT NOT NULL,
        episodes TEXT NOT NULL,
        type TEXT NOT NULL,
        image TEXT NOT NULL,
       )
      """
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
        "animes.db",
        version: 7,
        onCreate: (database, version) async {
          return createTable(database);
        }
    );
  }

  ///TODO: All Anime Workplace

  static Future<void> saveAnime(Anime anime) async {
    final db = await SqlHelper.db();
    await db.insert('animes', anime.toJson());
  }
  static Future<List<Anime>> getAllAnimes() async {
    final db = await SqlHelper.db();
    final maps = await db.query('animes');
    return maps.map((e) => Anime.fromJson(e)).toList();
  }
  static Future<void> deleteAnime(int? id) async {
    final db = await SqlHelper.db();
    await db.delete('animes', where: "id = ?", whereArgs: [id]);
  }
  static Future<void> updateAnime(int? id, Anime anime) async {
    final db = await SqlHelper.db();
    await db.update("animes", anime.toJson(), where: "id = ?", whereArgs: [id]);
  }
  static Future<void> clear() async {
    final db = await SqlHelper.db();
    await db.query("DELETE FROM animes");
  }

  ///TODO: Favourite Anime Workplace

  static Future<void> saveFavourite(Anime anime) async {
    final db = await SqlHelper.db();
    await db.insert('favouriteAnimes', anime.toJson());
  }
  static Future<List<Anime>> getAllFavouriteAnimes() async {
    final db = await SqlHelper.db();
    final maps = await db.query('favouriteAnimes');
    return maps.map((e) => Anime.fromJson(e)).toList();
  }
  static Future<void> deleteFavouriteAnime(int? id) async {
    final db = await SqlHelper.db();
    await db.delete('favouriteAnimes',where: "id = ?",whereArgs: [id]);
  }


}
