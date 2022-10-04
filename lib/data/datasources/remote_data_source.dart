import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:pokemon_app/data/models/api_object.dart';
import 'package:pokemon_app/data/models/pokemon_item.dart';

class RemoteDataSource {
  final _dio = Dio();
  final _baseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  Future<ApiObject> fetchFirstPokemonList() async {
    final Response response = await _dio.get(_baseUrl);

    ApiObject apiObject = ApiObject.fromJson(response.data);
    return apiObject;
  }

  Future<ApiObject> fetchPokemonList(int offset) async {
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

  Future<PokemonItem> fetchPokemon(int id) async {
    final Response response = await _dio.get(
      '$_baseUrl/$id/',
    );

    PokemonItem pokemonItem = PokemonItem.fromJson(response.data);
    return pokemonItem;
  }

  Future<Uint8List> fetchImage(String url) async {
    final image = await http.get(Uri.parse(url));
    return image.bodyBytes;
  }
}
