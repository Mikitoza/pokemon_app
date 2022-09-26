import 'package:pokemon_app/data/datasources/local_data_source.dart';
import 'package:pokemon_app/database/model/pokemon_db.dart';
import 'package:pokemon_app/domain/repository/pokemon_db_repository.dart';

class PokemonDBRepositoryImpl implements PokemonDBRepository {
  final LocalDataSource _localDataSource;

  PokemonDBRepositoryImpl(this._localDataSource);

  @override
  Future<PokemonDB> getPokemon(int id) async {
    final pokemons = await _localDataSource.getPokemons();
    return pokemons.firstWhere((pokemon) => pokemon.id == id);
  }

  @override
  Future<List<PokemonDB>> getPokemonList() async {
    return await _localDataSource.getPokemons();
  }

  @override
  Future<void> savePokemon(PokemonDB pokemonDB) async {
    await _localDataSource.save(pokemonDB);
  }
}
