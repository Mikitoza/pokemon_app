class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final int weight;
  final int height;
  final List<String> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.weight,
    required this.types,
    required this.height,
    required this.imageUrl,
  });
}
