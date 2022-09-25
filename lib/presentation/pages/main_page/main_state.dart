import 'package:equatable/equatable.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

enum MainStateStatus { initial, success, error, loading }

extension MainStateStatusX on MainStateStatus {
  bool get isInitial => this == MainStateStatus.initial;
  bool get isSuccess => this == MainStateStatus.success;
  bool get isError => this == MainStateStatus.error;
  bool get isLoading => this == MainStateStatus.loading;
}

class MainState extends Equatable {
  final MainStateStatus status;
  final int page;
  final int limit;
  final bool isLoadingMore;
  final List<Pokemon> pokemons;

  const MainState({
    this.status = MainStateStatus.initial,
    this.page = 0,
    this.limit = 10,
    required this.isLoadingMore,
    required this.pokemons,
  });

  MainState newState({
    MainStateStatus? status,
    int? page,
    int? limit,
    List<Pokemon>? pokemons,
    bool? isLoadingMore,
  }) {
    return MainState(
      status: status ?? this.status,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      pokemons: pokemons ?? this.pokemons,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        page,
        limit,
        pokemons,
        isLoadingMore,
      ];
}
