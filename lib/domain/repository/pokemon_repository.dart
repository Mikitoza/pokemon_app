import 'package:pokemon_app/data/models/api_object.dart';
import 'package:pokemon_app/data/models/pokemon_item.dart';

abstract class PokemonRepository {
  Future<List<PokemonApi>> getFirstPokemonList();
  Future<List<PokemonApi>> getPokemonList(int offset);
  Future<String> getPokemonImage(int id);
  Future<PokemonItem> getPokemon(int id);
}
