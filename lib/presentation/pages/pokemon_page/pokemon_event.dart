import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonInitialize extends PokemonEvent {
  final int id;
  final bool isOnline;

  PokemonInitialize({
    required this.id,
    required this.isOnline,
  });
}

class PokemonSave extends PokemonEvent {
  final int id;

  PokemonSave({required this.id});
}
