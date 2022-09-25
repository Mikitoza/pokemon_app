import 'package:equatable/equatable.dart';

enum PokemonStateStatus { initial, success, error, loading }

extension PokemonStateStatusX on PokemonStateStatus {
  bool get isInitial => this == PokemonStateStatus.initial;
  bool get isSuccess => this == PokemonStateStatus.success;
  bool get isError => this == PokemonStateStatus.error;
  bool get isLoading => this == PokemonStateStatus.loading;
}

class PokemonState extends Equatable {
  final PokemonStateStatus status;
  final String name;
  final List<String> types;
  final int weight;
  final int height;
  final String image;

  const PokemonState({
    required this.status,
    required this.name,
    required this.height,
    required this.image,
    required this.types,
    required this.weight,
  });

  PokemonState newState({
    PokemonStateStatus? status,
    String? name,
    List<String>? types,
    int? weight,
    int? height,
    String? image,
  }) {
    return PokemonState(
      status: status ?? this.status,
      name: name ?? this.name,
      height: height ?? this.height,
      image: image ?? this.image,
      types: types ?? this.types,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        types,
        weight,
        height,
        image,
      ];
}
