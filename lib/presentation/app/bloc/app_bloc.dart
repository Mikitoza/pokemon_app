import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/presentation/app/bloc/app_event.dart';
import 'package:pokemon_app/presentation/app/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppInitializeEvent>(
      _onInitialize,
    );
  }

  Future<void> _onInitialize(
      AppInitializeEvent event,
      Emitter<AppState> emit,
      ) async {
    emit(
      state.newState(),
    );
  }
}