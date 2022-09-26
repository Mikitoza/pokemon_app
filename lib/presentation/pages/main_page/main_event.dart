import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MainGetFirstPokemons extends MainEvent {}

class MainLoadMorePokemons extends MainEvent {
  final int offset;
  final int limit;

  MainLoadMorePokemons(
    this.offset,
    this.limit,
  );
}