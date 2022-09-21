import 'package:equatable/equatable.dart';

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
  final bool hasNextPage;
  final List pokemons;

  const MainState({
    this.status = MainStateStatus.initial,
    this.page = 0,
    this.limit = 20,
    this.hasNextPage = false,
    required this.pokemons,
  });

  MainState newState({
    MainStateStatus? status,
    int? page,
    int? limit,
    bool? hasNextPage,
    List? pokemons,
  }) {
    return MainState(
      status: status ?? this.status,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      pokemons: pokemons ?? this.pokemons,
    );
  }

  @override
  List<Object?> get props => [
        status,
        page,
        limit,
        hasNextPage,
        pokemons,
      ];
}
