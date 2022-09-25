import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/domain/usecase/main_usecase.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_event.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_state.dart';

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
    emit(
      state.newState(
        status: MainStateStatus.success,
        pokemons: await _mainUsecase.fetchFirstPokemons(),
      ),
    );
  }

  Future<void> _onLoadMorePokemons(
    MainLoadMorePokemons event,
    Emitter<MainState> emit,
  ) async {
    emit(state.newState(isLoadingMore: true));
    final pokemons = await _mainUsecase.fetchMorePokemons((state.page + 1) * 20);
    emit(
      state.newState(
        isLoadingMore: false,
        pokemons: state.pokemons..addAll(pokemons),
        page: state.page + 1,
        limit: state.limit * (state.page + 1),
      ),
    );
  }
}
