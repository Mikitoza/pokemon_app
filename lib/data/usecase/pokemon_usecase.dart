import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app/domain/entities/pokemon_detail.dart';
import 'package:pokemon_app/data/utils/pokemon_item_ext.dart';
import 'dart:typed_data';

class PokemonUsecase {
  final PokemonRepository _pokemonRepository;

  const PokemonUsecase(
    this._pokemonRepository,
  );

  Future<PokemonDetail> fetchPokemon(int id) async {
    final pokemon = await _pokemonRepository.fetchPokemon(id);
    return pokemon.parsePokemonItem();
  }

  Future<void> savePokemon(PokemonDB pokemon) async {
    await _pokemonRepository.savePokemon(pokemon);
  }

  Future<Uint8List> fetchImage(String url) async {
    return await _pokemonRepository.fetchImage(url);
  }
}
