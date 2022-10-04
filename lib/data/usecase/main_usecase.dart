import 'package:pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/utils/string_ext.dart';

class MainUsecase {
  final PokemonRepository _pokemonRepository;

  const MainUsecase(
    this._pokemonRepository,
  );

  Future<List<Pokemon>> fetchFirstPokemons() async {
    return Future.wait(
      (await _pokemonRepository.fetchFirstPokemonList())
          .map(
            (apiItem) async => Pokemon(
              title: apiItem.name,
              imgUrl: await _pokemonRepository.fetchPokemonImageUrl(
                apiItem.url.getIdFromUrl(),
              ),
              id: apiItem.url.getIdFromUrl(),
            ),
          )
          .toList(),
    );
  }

  Future<List<Pokemon>> fetchMorePokemons(int offset) async {
    return Future.wait(
      (await _pokemonRepository.fetchPokemonList(offset))
          .map(
            (apiItem) async => Pokemon(
              title: apiItem.name,
              imgUrl: await _pokemonRepository.fetchPokemonImageUrl(
                apiItem.url.getIdFromUrl(),
              ),
              id: apiItem.url.getIdFromUrl(),
            ),
          )
          .toList(),
    );
  }
}
