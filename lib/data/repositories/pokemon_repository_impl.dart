import 'package:pokemon_app/data/datasources/remote_data_source.dart';
import 'package:pokemon_app/data/models/api_object.dart';
import 'package:pokemon_app/data/models/pokemon_item.dart';
import 'package:pokemon_app/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final RemoteDataSource _remoteDataSource;

  PokemonRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PokemonApi>> getFirstPokemonList() async {
    return (await _remoteDataSource.getFirstPokemonList()).pokemons;
  }

  @override
  Future<String> getPokemonImage(int id) async {
    return (await _remoteDataSource.getPokemon(id)).imageUrl;
  }

  @override
  Future<List<PokemonApi>> getPokemonList(int offset) async {
    final pokemons = (await _remoteDataSource.getPokemonList(offset)).pokemons;
    return pokemons;
  }

  @override
  Future<PokemonItem> getPokemon(int id) async {
    return await _remoteDataSource.getPokemon(id);
  }
}
