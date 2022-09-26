import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/data/models/api_object.dart';
import 'package:pokemon_app/data/models/pokemon_item.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_app/domain/repository/pokemon_repository.dart';

import '../../utils/shared_mocks.mocks.dart';

void main() {
  final mockRemoteDataSource = MockRemoteDataSource();
  final PokemonRepository pokemonRepository = PokemonRepositoryImpl(mockRemoteDataSource);

  group('orders repository', () {
    test(
      'get pokemon list',
      () async {
        const data = ApiObject(
          pokemons: [],
          previous: null,
          count: 20,
          next: null,
        );

        when(
          mockRemoteDataSource.getPokemonList(20),
        ).thenAnswer((_) => Future.value(data));

        expect(
          await pokemonRepository.getPokemonList(20),
          data.pokemons,
        );
      },
    );

    test(
      'get pokemon',
      () async {
        const data = PokemonItem(
          name: '',
          imageUrl: '',
          weight: 100,
          height: 100,
          types: [],
        );
        const offset = 20;

        when(
          mockRemoteDataSource.getPokemon(offset),
        ).thenAnswer((_) => Future.value(data));

        expect(
          await pokemonRepository.getPokemon(offset),
          data,
        );
      },
    );

    test(
      'fetch image',
      () async {
        final data = Uint8List(1);
        const url = 'url';

        when(
          mockRemoteDataSource.fetchImage(url),
        ).thenAnswer((_) => Future.value(data));

        expect(
          await pokemonRepository.fetchImage(url),
          data,
        );
      },
    );

    test(
      'get first pokemon list',
      () async {
        const data = ApiObject(
          pokemons: [],
          previous: null,
          count: 20,
          next: null,
        );

        when(
          mockRemoteDataSource.getFirstPokemonList(),
        ).thenAnswer((_) => Future.value(data));

        expect(
          await pokemonRepository.getFirstPokemonList(),
          data.pokemons,
        );
      },
    );

    test(
      'get first pokemon list',
      () async {
        const id = 20;
        const data = PokemonItem(
          name: '',
          imageUrl: 'test',
          weight: 100,
          height: 100,
          types: [],
        );

        when(
          mockRemoteDataSource.getPokemon(id),
        ).thenAnswer((_) => Future.value(data));

        expect(
          await pokemonRepository.getPokemonImage(id),
          data.imageUrl,
        );
      },
    );
  });
}
