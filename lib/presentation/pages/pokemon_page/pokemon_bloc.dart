import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/domain/usecase/pokemon_usecase.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/pokemon_event.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonUsecase _pokemonUsecase;

  PokemonBloc(this._pokemonUsecase)
      : super(
          const PokemonState(
            status: PokemonStateStatus.initial,
            name: 'name',
            height: 0,
            image: 'image',
            types: [],
            weight: 0,
          ),
        ) {
    on<PokemonInitialize>(_onGetFirstPokemons);
  }

  Future<void> _onGetFirstPokemons(
    PokemonInitialize event,
    Emitter<PokemonState> emit,
  ) async {
    final pokemon = await _pokemonUsecase.fetchPokemon(event.id);
    emit(
      state.newState(
        status: PokemonStateStatus.success,
        name: pokemon.name,
        types: pokemon.types,
        weight: pokemon.weight,
        height: pokemon.height,
        image: pokemon.imageUrl,
      ),
    );
  }
}
