import 'package:pokemon_app/database/model/pokemon_db.dart';
import 'package:pokemon_app/domain/entities/pokemon_detail.dart';
import 'package:pokemon_app/domain/repository/pokemon_db_repository.dart';
import 'package:pokemon_app/domain/repository/pokemon_repository.dart';
import 'package:pokemon_app/domain/utils/pokemon_item_ext.dart';
import 'dart:typed_data';

class PokemonUsecase {
  final PokemonRepository _pokemonRepository;
  final PokemonDBRepository _pokemonDBRepository;

  const PokemonUsecase(this._pokemonRepository, this._pokemonDBRepository);

  Future<PokemonDetail> fetchPokemon(int id) async {
    final pokemon = await _pokemonRepository.getPokemon(id);
    return pokemon.parsePokemonItem();
  }

  Future<void> savePokemon(PokemonDB pokemon) async {
    await _pokemonDBRepository.savePokemon(pokemon);
  }

  Future<PokemonDetail> getPokemonFromDBPokemon(int id) async {
    final pokemon = await _pokemonDBRepository.getPokemon(id);
    return PokemonDetail(
      name: pokemon.name!,
      weight: pokemon.weight!,
      types: [pokemon.type!],
      height: pokemon.height!,
      imageUrl: pokemon.image!,
    );
  }

  Future<List<PokemonDetail>> getPokemonsFromDBPokemon() async {
    final pokemons = await _pokemonDBRepository.getPokemonList();
    return pokemons
        .map(
          (pokemon) => PokemonDetail(
            name: pokemon.name!,
            weight: pokemon.weight!,
            types: [pokemon.type!],
            height: pokemon.height!,
            imageUrl: pokemon.image!,
          ),
        )
        .toList();
  }

  Future<Uint8List> fetchImage(String url) async {
    return await _pokemonRepository.fetchImage(url);
  }
}
