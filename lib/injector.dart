import 'package:get_it/get_it.dart';
import 'package:pokemon_app/data/datasources/local_data_source.dart';
import 'package:pokemon_app/data/datasources/remote_data_source.dart';
import 'package:pokemon_app/data/repositories/pokemon_db_repository_impl.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_app/database/db_helper.dart';
import 'package:pokemon_app/domain/repository/pokemon_db_repository.dart';
import 'package:pokemon_app/domain/repository/pokemon_repository.dart';
import 'package:pokemon_app/domain/usecase/main_usecase.dart';
import 'package:pokemon_app/domain/usecase/pokemon_usecase.dart';
import 'package:pokemon_app/presentation/app/app_bloc.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_bloc.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/pokemon_bloc.dart';

final locator = GetIt.instance;

void setUp() {
  _setUpDataSources();
  _setUpRepositories();
  _setUpUseCases();
  _setUpBlocs();
}

void _setUpDataSources() async {
  locator.registerFactory<RemoteDataSource>(
    () => RemoteDataSource(),
  );
  locator.registerFactory<LocalDataSource>(
    () {
      return LocalDataSource(DBHelper());
    },
  );
}

void _setUpRepositories() {
  locator.registerFactory<PokemonRepository>(
    () => PokemonRepositoryImpl(locator.get<RemoteDataSource>()),
  );
  locator.registerFactory<PokemonDBRepository>(
    () => PokemonDBRepositoryImpl(locator.get<LocalDataSource>()),
  );
}

void _setUpUseCases() {
  locator.registerFactory<MainUsecase>(
    () => MainUsecase(
      locator.get<PokemonRepository>(),
      locator.get<PokemonDBRepository>(),
    ),
  );
  locator.registerFactory<PokemonUsecase>(
    () => PokemonUsecase(
      locator.get<PokemonRepository>(),
      locator.get<PokemonDBRepository>(),
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
  locator.registerFactory<PokemonBloc>(
    () => PokemonBloc(
      locator.get<PokemonUsecase>(),
    ),
  );
}
