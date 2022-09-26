import 'package:mockito/annotations.dart';
import 'package:pokemon_app/data/datasources/remote_data_source.dart';
import 'package:pokemon_app/data/datasources/local_data_source.dart';
import 'package:pokemon_app/domain/usecase/main_usecase.dart';
import 'package:pokemon_app/domain/usecase/pokemon_usecase.dart';

@GenerateMocks([
  RemoteDataSource,
  LocalDataSource,

  MainUsecase,
  PokemonUsecase,
])
class SharedMocks {}
