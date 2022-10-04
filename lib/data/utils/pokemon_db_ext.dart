import 'package:pokemon_app/data/models/pokemon_db.dart';
import 'package:pokemon_app/data/models/pokemon_item.dart';

extension PokemonDBX on PokemonDB {
  PokemonItem parsePokemonDb() {
    return PokemonItem(
      name: name!,
      weight: weight!,
      types: [
        TypesApi(
          slot: 0,
          type: Type(
            name: type!,
            url: 'url',
          ),
        ),
      ],
      height: height!,
      imageUrl: image!,
    );
  }
}
