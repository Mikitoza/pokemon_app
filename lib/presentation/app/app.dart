import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokemon_app/core/injector.dart';
import 'package:pokemon_app/data/usecase/main_usecase.dart';
import 'package:pokemon_app/data/usecase/pokemon_usecase.dart';
import 'package:pokemon_app/l10n/app_localizations.dart';
import 'package:pokemon_app/presentation/app/bloc/app_bloc.dart';
import 'package:pokemon_app/presentation/app/bloc/app_state.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_bloc.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_page.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/bloc/pokemon_bloc.dart';
import 'package:pokemon_app/presentation/theme/theme.dart';
import 'package:pokemon_app/presentation/theme/theme_prodiver.dart';

class PokemonApp extends StatefulWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  State<PokemonApp> createState() => _PokemonAppState();
}

class _PokemonAppState extends State<PokemonApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (BuildContext context) => AppBloc(),
        ),
        BlocProvider<MainBloc>(
          create: (BuildContext context) => MainBloc(
            locator.get<MainUsecase>(),
          ),
        ),
        BlocProvider<PokemonBloc>(
          create: (BuildContext context) => PokemonBloc(
            locator.get<PokemonUsecase>(),
          ),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        bloc: BlocProvider.of<AppBloc>(context),
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
      ),
    );
  }
}
