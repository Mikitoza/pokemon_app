import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/data/repositories/pokemon_db_repository_impl.dart';
import 'package:pokemon_app/database/model/pokemon_db.dart';
import 'package:pokemon_app/domain/repository/pokemon_db_repository.dart';

import '../../utils/shared_mocks.mocks.dart';

void main() {
  final mockLocalDataSource = MockLocalDataSource();
  final PokemonDBRepository pokemonDBRepository = PokemonDBRepositoryImpl(mockLocalDataSource);

  group(
    'orders repository',
    () {
      test(
        'get pokemon by id',
        () async {
          const id = 2;
          final pokemons = [
            PokemonDB(
              'name',
              'image',
              100,
              100,
              1,
              'type',
            ),
            PokemonDB(
              'name',
              'image',
              100,
              100,
              id,
              'type',
            ),
            PokemonDB(
              'name',
              'image',
              100,
              100,
              3,
              'type',
            ),
          ];

          when(mockLocalDataSource.getPokemons()).thenAnswer((_) => Future.value(pokemons));

          expect(
            await pokemonDBRepository.getPokemon(id),
            pokemons.firstWhere((pok) => pok.id == id),
          );
        },
      );
      test(
        'get pokemon list',
        () async {
          final pokemons = [
            PokemonDB(
              'name',
              'image',
              100,
              100,
              1,
              'type',
            ),
            PokemonDB(
              'name',
              'image',
              100,
              100,
              2,
              'type',
            ),
            PokemonDB(
              'name',
              'image',
              100,
              100,
              3,
              'type',
            ),
          ];

          when(mockLocalDataSource.getPokemons()).thenAnswer((_) => Future.value(pokemons));

          expect(
            await pokemonDBRepository.getPokemonList(),
            pokemons,
          );
        },
      );
    },
  );
}
