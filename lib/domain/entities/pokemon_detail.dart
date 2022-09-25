class PokemonDetail {
  final String name;
  final String imageUrl;
  final int weight;
  final int height;
  final List<String> types;

  const PokemonDetail({
    required this.name,
    required this.weight,
    required this.types,
    required this.height,
    required this.imageUrl,
  });
}
