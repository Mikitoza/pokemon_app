import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String weight = 'weight';
  static const String height = 'height';
  static const String image = 'image';
  static const String table = 'pokemonsTable';
  static const String dbName = 'pokemons.db';

  Future<Database?> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $table ($id INTEGER, $name TEXT , $type TEXT, $weight INTEGER ,$height INTEGER, $image TEXT)',
    );
  }

  Future<PokemonDB> save(PokemonDB pokemonDB) async {
    var dbClient = await db;
    pokemonDB.id = await dbClient!.insert(table, pokemonDB.toMap());
    return pokemonDB;
  }

  Future<List<PokemonDB>> getPokemons() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!.query(table, columns: [
      id,
      name,
      type,
      weight,
      height,
      image,
    ]);
    List<PokemonDB> photos = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(PokemonDB.fromMap(Map<String, dynamic>.from(maps[i])));
      }
    }
    return photos;
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
