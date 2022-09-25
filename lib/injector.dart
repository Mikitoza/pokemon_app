import 'package:get_it/get_it.dart';
import 'package:pokemon_app/data/datasources/remote_data_source.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_app/domain/repository/pokemon_repository.dart';
import 'package:pokemon_app/domain/usecase/main_usecase.dart';
import 'package:pokemon_app/presentation/app/app_bloc.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_bloc.dart';

final locator = GetIt.instance;

void setUp() {
  _setUpDataSources();
  _setUpRepositories();
  _setUpUseCases();
  _setUpBlocs();
}

void _setUpDataSources() {
  locator.registerFactory<RemoteDataSource>(
    () => RemoteDataSource(),
  );
}

void _setUpRepositories() {
  locator.registerFactory<PokemonRepository>(
    () => PokemonRepositoryImpl(locator.get<RemoteDataSource>()),
  );
}

void _setUpUseCases() {
  locator.registerFactory<MainUsecase>(
    () => MainUsecase(
      locator.get<PokemonRepository>(),
    ),
  );
}

void _setUpBlocs() {
  locator.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  locator.registerFactory<MainBloc>(
    () => MainBloc(
      locator.get<MainUsecase>(),
    ),
  );
}
