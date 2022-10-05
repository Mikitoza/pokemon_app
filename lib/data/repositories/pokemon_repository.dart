import 'dart:typed_data';

import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<void> savePokemon(PokemonDB pokemonDB);
  Future<List<Pokemon>> fetchFirstPokemonList();
  Future<String> fetchPokemonImageUrl(int id);
  Future<List<Pokemon>> fetchPokemonList(int offset);
  Future<Pokemon> fetchPokemon(int id);
  Future<Uint8List> fetchImage(String url);
}
