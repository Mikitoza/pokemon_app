import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokemon_app/database/model/pokemon_db.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String TYPE = 'type';
  static const String WEIGHT = 'weight';
  static const String HEIGHT = 'height';
  static const String IMAGE = 'image';
  static const String TABLE = 'pokemonsTable';
  static const String DB_Name = 'pokemons.db';

  Future<Database?> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    print('object');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    print('test');
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT , $TYPE TEXT, $WEIGHT INTEGER ,$HEIGHT INTEGER, $IMAGE TEXT)');
  }

  Future<PokemonDB> save(PokemonDB pokemonDB) async {
    var dbClient = await db;
    pokemonDB.id = await dbClient!.insert(TABLE, pokemonDB.toMap());
    return pokemonDB;
  }

  Future<List<PokemonDB>> getPokemons() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!.query(TABLE, columns: [
      ID,
      NAME,
      TYPE,
      WEIGHT,
      HEIGHT,
      IMAGE,
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
