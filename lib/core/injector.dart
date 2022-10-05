import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_app/core/platform/network_info.dart';
import 'package:pokemon_app/data/database/db_helper.dart';
import 'package:pokemon_app/data/datasources/local_data_source.dart';
import 'package:pokemon_app/data/datasources/remote_data_source.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_app/domain/usecase/main_usecase.dart';
import 'package:pokemon_app/domain/usecase/pokemon_usecase.dart';
import 'package:pokemon_app/presentation/app/bloc/app_bloc.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_bloc.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/bloc/pokemon_bloc.dart';

final locator = GetIt.instance;

void setUp() async {
  _setUpDataSources();
  _setUpPlatforms();
  _setUpRepositories();
  _setUpUseCases();
  _setUpBlocs();
}

void _setUpPlatforms() async {
  locator.registerFactory<NetworkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );
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

void _setUpRepositories() async {
  locator.registerFactory<PokemonRepository>(
    () => PokemonRepositoryImpl(
      locator.get<RemoteDataSource>(),
      locator.get<LocalDataSource>(),
      locator.get<NetworkInfo>(),
    ),
  );
}

void _setUpUseCases() async {
  locator.registerSingleton<MainUsecase>(
    MainUsecase(
      locator.get<PokemonRepository>(),
    ),
  );
  locator.registerSingleton<PokemonUsecase>(
    PokemonUsecase(
      locator.get<PokemonRepository>(),
    ),
  );
}

void _setUpBlocs() async {
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
