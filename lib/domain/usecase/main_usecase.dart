import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/repository/pokemon_db_repository.dart';
import 'package:pokemon_app/domain/repository/pokemon_repository.dart';
import 'package:pokemon_app/domain/utils/string_ext.dart';

class MainUsecase {
  final PokemonRepository _pokemonRepository;
  final PokemonDBRepository _pokemonDBRepository;

  const MainUsecase(
    this._pokemonRepository,
    this._pokemonDBRepository,
  );

  Future<List<Pokemon>> fetchFirstPokemons() async {
    return Future.wait(
      (await _pokemonRepository.getFirstPokemonList())
          .map(
            (apiItem) async => Pokemon(
              title: apiItem.name,
              imgUrl: await _pokemonRepository.getPokemonImage(
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
      (await _pokemonRepository.getPokemonList(offset))
          .map(
            (apiItem) async => Pokemon(
              title: apiItem.name,
              imgUrl: await _pokemonRepository.getPokemonImage(
                apiItem.url.getIdFromUrl(),
              ),
              id: apiItem.url.getIdFromUrl(),
            ),
          )
          .toList(),
    );
  }

  Future<List<Pokemon>> fetchPokemonsFromDB() async {
    final pokemons = await _pokemonDBRepository.getPokemonList();
    return pokemons
        .map(
          (pokemon) => Pokemon(
            title: pokemon.name!,
            imgUrl: pokemon.image!,
            id: pokemon.id!,
          ),
        )
        .toList();
  }
}
