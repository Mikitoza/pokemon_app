import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_bloc.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_event.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_state.dart';

import '../../utils/shared_mocks.mocks.dart';

void main() {
  group('main bloc', () {
    final mockMainUsecase = MockMainUsecase();

    blocTest<MainBloc, MainState>(
      'get first pokemons',
      build: () => MainBloc(mockMainUsecase),
      act: (bloc) => bloc.add(MainGetFirstPokemons()),
      expect: () => [
        const MainState(
          pokemons: [],
          isLoadingMore: false,
          status: MainStateStatus.loading,
        ),
      ],
    );

    blocTest<MainBloc, MainState>(
      'load more pokemons',
      build: () => MainBloc(mockMainUsecase),
      act: (bloc) => bloc.add(MainLoadMorePokemons(20, 20)),
      seed: () => const MainState(
        status: MainStateStatus.initial,
        page: 0,
        limit: 10,
        isLoadingMore: true,
        pokemons: [],
        isOnline: true,
      ),
      expect: () => [
        const MainState(
          pokemons: [],
          isLoadingMore: true,
          status: MainStateStatus.error,
          errorDesc: "Failed",
        ),
      ],
    );
  });
}
