import 'package:dio/dio.dart';
import 'package:pokemon_app/data/models/api_object.dart';
import 'package:pokemon_app/data/models/pokemon_item.dart';

class RemoteDataSource {
  final _dio = Dio();
  final _baseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  Future<ApiObject> getFirstPokemonList() async {
    final Response response = await _dio.get(_baseUrl);

    ApiObject apiObject = ApiObject.fromJson(response.data);
    return apiObject;
  }

  Future<ApiObject> getPokemonList(int offset) async {
    final Response response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'offset': offset,
        'limit': 20,
      },
    );

    ApiObject apiObject = ApiObject.fromJson(response.data);
    return apiObject;
  }

  Future<PokemonItem> getPokemon(int id) async {
    final Response response = await _dio.get(
      '$_baseUrl/$id/',
    );

    PokemonItem pokemonItem = PokemonItem.fromJson(response.data);
    return pokemonItem;
  }
}
