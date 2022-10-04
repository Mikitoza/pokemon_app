import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_app/core/platform/network_info.dart';
import 'package:pokemon_app/data/database/db_helper.dart';
import 'package:pokemon_app/data/datasources/local_data_source.dart';
import 'package:pokemon_app/data/datasources/remote_data_source.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:pokemon_app/data/usecase/main_usecase.dart';
import 'package:pokemon_app/data/usecase/pokemon_usecase.dart';

final locator = GetIt.instance;
final DBHelper _dbHelper = DBHelper();

void setUp() async {
  await _dbHelper.initDB();
  _setUpPlatforms();
  _setUpDataSources();
  _setUpRepositories();
  _setUpUseCases();
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
      return LocalDataSource(_dbHelper);
    },
  );
}

void _setUpRepositories() {
  locator.registerFactory<PokemonRepository>(
    () => PokemonRepository(
      locator.get<RemoteDataSource>(),
      locator.get<LocalDataSource>(),
      locator.get<NetworkInfo>(),
    ),
  );
}

void _setUpUseCases() {
  locator.registerFactory<MainUsecase>(
    () => MainUsecase(
      locator.get<PokemonRepository>(),
    ),
  );
  locator.registerFactory<PokemonUsecase>(
    () => PokemonUsecase(
      locator.get<PokemonRepository>(),
    ),
  );
}
