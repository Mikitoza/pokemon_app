import 'package:flutter/material.dart';
import 'package:pokemon_app/presentation/app/app.dart';
import 'package:pokemon_app/injector.dart';

import 'database/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DBHelper dbHelper = DBHelper();
  await dbHelper.initDB();
  setUp();
  runApp(const PokemonApp());
}
