import 'package:pokemon_app/domain/entities/pokemon_detail.dart';
import 'package:pokemon_app/domain/repository/pokemon_repository.dart';
import 'package:pokemon_app/domain/utils/pokemon_item_ext.dart';

class PokemonUsecase {
  final PokemonRepository _pokemonRepository;

  const PokemonUsecase(this._pokemonRepository);

  Future<PokemonDetail> fetchPokemon(int id) async {
    final pokemon = await _pokemonRepository.getPokemon(id);
    return pokemon.parsePokemonItem();
  }
}
