import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/data/usecase/main_usecase.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_event.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainUsecase _mainUsecase;

  MainBloc(this._mainUsecase)
      : super(
          const MainState(
            pokemons: [],
            isLoadingMore: false,
          ),
        ) {
    on<MainGetFirstPokemons>(_onGetFirstPokemons);
    on<MainLoadMorePokemons>(_onLoadMorePokemons);
  }

  Future<void> _onGetFirstPokemons(
    MainGetFirstPokemons event,
    Emitter<MainState> emit,
  ) async {
    emit(state.newState(status: MainStateStatus.loading));
    try {
      final result = await InternetAddress.lookup('example.com');
      result.isNotEmpty && result[0].rawAddress.isNotEmpty
          ? null
          : emit(
              state.newState(isOnline: false),
            );
    } on SocketException catch (_) {
      emit(
        state.newState(
          isOnline: false,
        ),
      );
    }
    if (state.isOnline) {
      try {
        emit(
          state.newState(
            status: MainStateStatus.success,
            pokemons: await _mainUsecase.fetchFirstPokemons(),
          ),
        );
      } catch (_) {
        emit(
          state.newState(
            status: MainStateStatus.error,
            errorDesc: 'Failed',
          ),
        );
      }
    } else {
      try {
        emit(
          state.newState(
            status: MainStateStatus.success,
            pokemons: await _mainUsecase.getPokemonsItems(),
          ),
        );
      } catch (_) {
        emit(
          state.newState(
            status: MainStateStatus.error,
            errorDesc: 'Failed',
          ),
        );
      }
    }
  }

  Future<void> _onLoadMorePokemons(
    MainLoadMorePokemons event,
    Emitter<MainState> emit,
  ) async {
    emit(state.newState(isLoadingMore: true));
    try {
      final pokemons = await _mainUsecase.fetchMorePokemons((state.page + 1) * 20);
      emit(
        state.newState(
          isLoadingMore: false,
          pokemons: state.pokemons..addAll(pokemons),
          page: state.page + 1,
          limit: state.limit * (state.page + 1),
        ),
      );
    } catch (_) {
      emit(
        state.newState(
          status: MainStateStatus.error,
          errorDesc: 'Failed',
        ),
      );
    }
  }
}
