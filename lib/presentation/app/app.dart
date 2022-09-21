import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokemon_app/injector.dart';
import 'package:pokemon_app/l10n/app_localizations.dart';
import 'package:pokemon_app/presentation/app/app_bloc.dart';
import 'package:pokemon_app/presentation/app/app_state.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_page.dart';
import 'package:pokemon_app/presentation/theme/theme.dart';
import 'package:pokemon_app/presentation/theme/theme_prodiver.dart';

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
          theme: theme,
          child: Builder(
            builder: (context) {
              return const MaterialApp(
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                home: MainPage(),
              );
            },
          ),
        );
      },
    );
  }
}
