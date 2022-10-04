abstract class PokemonEvent {}

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
