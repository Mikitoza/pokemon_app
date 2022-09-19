import 'package:equatable/equatable.dart';

enum AppStateStatus { initial, success, error, loading }

extension AppStateStatusX on AppStateStatus {
  bool get isInitial => this == AppStateStatus.initial;
  bool get isSuccess => this == AppStateStatus.success;
  bool get isError => this == AppStateStatus.error;
  bool get isLoading => this == AppStateStatus.loading;
}

class AppState extends Equatable {
  final AppStateStatus status;

  const AppState({
    this.status = AppStateStatus.initial,
  });

  AppState newState({
    AppStateStatus? status,
  }) {
    return AppState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    status,
  ];
}