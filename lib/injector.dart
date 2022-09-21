import 'package:get_it/get_it.dart';
import 'package:pokemon_app/presentation/app/app_bloc.dart';

final locator = GetIt.instance;

void setUp() {
  _setUpDataSources();
  _setUpPlatform();
  _setUpRepositories();
  _setUpUseCases();
  _setUpBlocs();
}

void _setUpDataSources() {}

void _setUpPlatform() {}

void _setUpRepositories() {}

void _setUpUseCases() {}

void _setUpBlocs() {
  locator.registerFactory<AppBloc>(
    () => AppBloc(),
  );
}
