import 'package:pokemon_app/database/db_helper.dart';
import 'package:pokemon_app/database/model/pokemon_db.dart';

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
