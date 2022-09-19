import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/injector.dart';
import 'package:pokemon_app/presentation/app/app_bloc.dart';
import 'package:pokemon_app/presentation/app/app_state.dart';

class PokemonApp extends StatefulWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  State<PokemonApp> createState() => _PokemonAppState();
}

class _PokemonAppState extends State<PokemonApp> {
  final _bloc = locator.get<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      bloc: _bloc,
      builder: (context, state) {
        return ThemeProvider(
          theme: state.themeType == ThemeType.dark ? darkTheme : lightTheme,
          child: Builder(
            builder: (context) {
              return const MaterialApp(
                home: MainPage(),
              );
            },
          ),
        );
      },
    );
  }
}