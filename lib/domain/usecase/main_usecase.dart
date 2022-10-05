import 'package:pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

class MainUsecase {
  final PokemonRepository _pokemonRepository;

  const MainUsecase(
    this._pokemonRepository,
  );

  Future<List<Pokemon>> fetchFirstPokemons() async {
    return await _pokemonRepository.fetchFirstPokemonList();
  }

  Future<List<Pokemon>> fetchMorePokemons(int offset) async {
    return await _pokemonRepository.fetchPokemonList(offset);
  }
}
