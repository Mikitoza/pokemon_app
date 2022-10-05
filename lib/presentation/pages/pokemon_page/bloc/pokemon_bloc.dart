import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/core/ui/utils/image_util.dart';
import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:pokemon_app/domain/usecase/pokemon_usecase.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/bloc/pokemon_event.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/bloc/pokemon_state.dart';

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
            errorDesc: '',
          ),
        ) {
    on<PokemonInitialize>(_onGetPokemon);
    on<PokemonSave>(_onSavePokemonInDB);
  }

  Future<void> _onGetPokemon(
    PokemonInitialize event,
    Emitter<PokemonState> emit,
  ) async {
    if (event.isOnline) {
      try {
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
      } catch (_) {
        emit(
          state.newState(
            status: PokemonStateStatus.error,
            errorDesc: 'Some error',
          ),
        );
      }
    } else {
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

  Future<void> _onSavePokemonInDB(
    PokemonSave event,
    Emitter<PokemonState> emit,
  ) async {
    emit(state.newState(status: PokemonStateStatus.loading));
    final pokemons = await _pokemonUsecase.fetchPokemons();
    final isExist = pokemons.firstWhereOrNull((pokemon) => pokemon.name == state.name) != null;
    if (!isExist) {
      final image = await _pokemonUsecase.fetchImage(state.image);
      await _pokemonUsecase.savePokemon(
        PokemonDB(
          state.name,
          Utility.base64String(image),
          state.weight,
          state.height,
          event.id,
          state.types.first,
        ),
      );
      emit(state.newState(status: PokemonStateStatus.success));
    } else {
      emit(
        state.newState(
          status: PokemonStateStatus.error,
          errorDesc: 'This pokemon is already in database',
        ),
      );
    }
  }
}
