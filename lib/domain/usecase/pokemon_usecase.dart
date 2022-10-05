import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'dart:typed_data';

class PokemonUsecase {
  final PokemonRepository _pokemonRepository;

  const PokemonUsecase(
    this._pokemonRepository,
  );

  Future<Pokemon> fetchPokemon(int id) async {
    return await _pokemonRepository.fetchPokemon(id);
  }

  Future<void> savePokemon(PokemonDB pokemon) async {
    await _pokemonRepository.savePokemon(pokemon);
  }

  Future<Uint8List> fetchImage(String url) async {
    return await _pokemonRepository.fetchImage(url);
  }

  Future<List<Pokemon>> fetchPokemons() async {
    return await _pokemonRepository.fetchFirstPokemonList();
  }
}
