import 'package:pokemon_app/database/model/pokemon_db.dart';

abstract class PokemonDBRepository {
  Future<List<PokemonDB>> getPokemonList();
  Future<PokemonDB> getPokemon(int id);
  Future<void> savePokemon(PokemonDB pokemonDB);
}
