import 'package:pokemon_app/data/models/pokemon_item.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

extension PokemonItemX on PokemonItem {
  Pokemon parsePokemonItem(int id) {
    return Pokemon(
      id: id,
      name: name,
      weight: weight,
      types: types.map((type) => type.type.name).toList(),
      height: height,
      imageUrl: imageUrl,
    );
  }
}
