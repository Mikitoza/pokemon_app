import 'dart:typed_data';

import 'package:pokemon_app/core/platform/network_info.dart';
import 'package:pokemon_app/data/datasources/local_data_source.dart';
import 'package:pokemon_app/data/datasources/remote_data_source.dart';
import 'package:pokemon_app/data/models/api_object.dart';
import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:pokemon_app/data/models/pokemon_item.dart';
import 'package:pokemon_app/data/utils/pokemon_db_ext.dart';

class PokemonRepository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  const PokemonRepository(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  Future<void> savePokemon(PokemonDB pokemonDB) async {
    await _localDataSource.save(pokemonDB);
  }

  Future<List<PokemonApi>> fetchFirstPokemonList() async {
    if (await _networkInfo.isConnected) {
      return (await _remoteDataSource.getFirstPokemonList()).pokemons;
    } else {
      return (await _localDataSource.getPokemons())
          .map(
            (pokemon) => PokemonApi(name: pokemon.name!, url: 'url'),
          )
          .toList();
    }
  }

  Future<String> fetchPokemonImageUrl(int id) async {
    return (await _remoteDataSource.getPokemon(id)).imageUrl;
  }

  Future<List<PokemonApi>> fetchPokemonList(int offset) async {
    final pokemons = (await _remoteDataSource.getPokemonList(offset)).pokemons;
    return pokemons;
  }

  Future<PokemonItem> fetchPokemon(int id) async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.getPokemon(id);
    } else {
      final pokemons = await _localDataSource.getPokemons();
      return pokemons.firstWhere((pokemon) => pokemon.id == id).parsePokemonDb();
    }
  }

  Future<Uint8List> fetchImage(String url) async {
    return await _remoteDataSource.fetchImage(url);
  }

  Future<List<PokemonItem>> getPokemonsItems() async {
    final pokemons = await _localDataSource.getPokemons();
    return pokemons
        .map(
          (pokemon) => PokemonItem(
            name: pokemon.name!,
            weight: pokemon.weight!,
            types: [
              TypesApi(
                slot: 0,
                type: Type(
                  name: pokemon.type!,
                  url: 'url',
                ),
              ),
            ],
            height: pokemon.height!,
            imageUrl: pokemon.image!,
          ),
        )
        .toList();
  }
}
