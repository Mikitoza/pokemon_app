import 'package:pokemon_app/data/models/api_object.dart';

abstract class PokemonRepository {
  Future<List<PokemonApi>> getFirstPokemonList();
  Future<List<PokemonApi>> getPokemonList(int offset);
  Future<String> getPokemonImage(int id);
}
