import 'package:equatable/equatable.dart';

class ApiObject extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonApi> pokemons;

  const ApiObject({
    required this.pokemons,
    required this.previous,
    required this.count,
    required this.next,
  });

  factory ApiObject.fromJson(Map<String, dynamic> json) => ApiObject(
        previous: json['previous'],
        count: json['count'] as int,
        next: json['next'],
        pokemons: (json['results'] as List).map((pokemon) => PokemonApi.fromJson(pokemon)).toList(),
      );

  @override
  List<Object?> get props => [count, next, previous, pokemons];
}

class PokemonApi {
  final String name;
  final String url;

  const PokemonApi({
    required this.name,
    required this.url,
  });

  factory PokemonApi.fromJson(Map<String, dynamic> json) => PokemonApi(
        name: json['name'],
        url: json['url'],
      );
}
