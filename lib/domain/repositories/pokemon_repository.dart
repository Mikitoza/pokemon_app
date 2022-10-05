import 'dart:typed_data';

import 'package:pokemon_app/core/platform/network_info.dart';
import 'package:pokemon_app/data/datasources/local_data_source.dart';
import 'package:pokemon_app/data/datasources/remote_data_source.dart';
import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app/data/utils/pokemon_db_ext.dart';
import 'package:pokemon_app/data/utils/pokemon_item_ext.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/utils/string_ext.dart';

class PokemonRepositoryImpl implements PokemonRepository{
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  const PokemonRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<void> savePokemon(PokemonDB pokemonDB) async {
    await _localDataSource.save(pokemonDB);
  }

  @override
  Future<List<Pokemon>> fetchFirstPokemonList() async {
    if (await _networkInfo.isConnected) {
      return Future.wait((await _remoteDataSource.fetchFirstPokemonList())
          .pokemons
          .map((pokemon) => fetchPokemon(pokemon.url.getIdFromUrl()))
          .toList());
    } else {
      return (await _localDataSource.getPokemons())
          .map(
            (pokemon) => pokemon.parsePokemonDb(),
          )
          .toList();
    }
  }

  @override
  Future<String> fetchPokemonImageUrl(int id) async {
    return (await _remoteDataSource.fetchPokemon(id)).imageUrl;
  }

  @override
  Future<List<Pokemon>> fetchPokemonList(int offset) async {
    return Future.wait((await _remoteDataSource.fetchPokemonList(offset))
        .pokemons
        .map((pokemon) => fetchPokemon(pokemon.url.getIdFromUrl()))
        .toList());
  }

  @override
  Future<Pokemon> fetchPokemon(int id) async {
    if (await _networkInfo.isConnected) {
      return (await _remoteDataSource.fetchPokemon(id)).parsePokemonItem(id);
    } else {
      final pokemons = await _localDataSource.getPokemons();
      return pokemons.firstWhere((pokemon) => pokemon.id == id).parsePokemonDb();
    }
  }

  @override
  Future<Uint8List> fetchImage(String url) async {
    return await _remoteDataSource.fetchImage(url);
  }
}
