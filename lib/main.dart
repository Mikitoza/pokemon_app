import 'package:flutter/material.dart';
import 'package:pokemon_app/core/injector.dart';
import 'package:pokemon_app/presentation/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(const PokemonApp());
}
