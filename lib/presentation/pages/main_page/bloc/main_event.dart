abstract class MainEvent {}

class MainGetFirstPokemons extends MainEvent {}

class MainLoadMorePokemons extends MainEvent {
  final int offset;
  final int limit;

  MainLoadMorePokemons(
    this.offset,
    this.limit,
  );
}
