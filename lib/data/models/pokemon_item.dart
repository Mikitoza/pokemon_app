class PokemonItem {
  final String name;
  final String imageUrl;
  final List<TypesApi> types;
  final int weight;
  final int height;

  const PokemonItem({
    required this.types,
    required this.name,
    required this.height,
    required this.imageUrl,
    required this.weight,
  });

  factory PokemonItem.fromJson(Map<String, dynamic> json) => PokemonItem(
        types: (json['types'] as List).map((type) => TypesApi.fromJson(type)).toList(),
        name: json['name'],
        height: json['height'],
        imageUrl: json['sprites']['front_default'],
        weight: json['weight'],
      );
}

class TypesApi {
  final int slot;
  final Type type;

  const TypesApi({
    required this.slot,
    required this.type,
  });

  factory TypesApi.fromJson(Map<String, dynamic> json) => TypesApi(
        slot: json['slot'],
        type: Type.fromJson(json['type']),
      );
}

class Type {
  final String name;
  final String url;

  const Type({
    required this.name,
    required this.url,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json['name'],
        url: json['url'],
      );
}
