import 'package:flutter/material.dart';
import 'package:pokemon_app/data/database/db_helper.dart';
import 'package:pokemon_app/core/injector.dart';
import 'package:pokemon_app/presentation/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initDB();
  setUp();
  runApp(const PokemonApp());
}
