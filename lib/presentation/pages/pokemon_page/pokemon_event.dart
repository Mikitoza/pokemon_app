import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonInitialize extends PokemonEvent {
  final int id;

  PokemonInitialize({required this.id});
}
