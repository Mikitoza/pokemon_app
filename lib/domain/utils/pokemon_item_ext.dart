import 'package:pokemon_app/data/models/pokemon_item.dart';
import 'package:pokemon_app/domain/entities/pokemon_detail.dart';

extension PokemonItemX on PokemonItem {
  PokemonDetail parsePokemonItem() {
    return PokemonDetail(
      name: name,
      weight: weight,
      types: types.map((type) => type.type.name).toList(),
      height: height,
      imageUrl: imageUrl,
    );
  }
}
