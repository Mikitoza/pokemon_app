import 'package:pokemon_app/data/database/db_helper.dart';
import 'package:pokemon_app/data/models/pokemon_db.dart';

class LocalDataSource {
  final DBHelper _dbHelper;

  const LocalDataSource(this._dbHelper);

  Future<void> save(PokemonDB pokemonDB) async {
    _dbHelper.save(pokemonDB);
  }

  Future<List<PokemonDB>> getPokemons() async {
    return await _dbHelper.getPokemons();
  }
}
