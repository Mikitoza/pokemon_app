import 'package:equatable/equatable.dart';

class PokemonDB extends Equatable {
  late int? id;
  late String? name;
  late String? image;
  late int? weight;
  late int? height;
  late String? type;

  PokemonDB(
    this.name,
    this.image,
    this.weight,
    this.height,
    this.id,
    this.type,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'weight': weight,
      'height': height,
      'image': image,
    };
    return map;
  }

  PokemonDB.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
    weight = map['weight'];
    height = map['height'];
    type = map['type'];
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        weight,
        height,
        type,
      ];
}
