import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

extension PokemonDBX on PokemonDB {
  Pokemon parsePokemonDb() {
    return Pokemon(
      id: id!,
      name: name!,
      weight: weight!,
      types: [type!],
      height: height!,
      imageUrl: image!,
    );
  }
}
