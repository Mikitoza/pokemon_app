import 'package:flutter/material.dart';
import 'package:pokemon_app/l10n/app_localizations.dart';
import 'package:pokemon_app/presentation/theme/theme_prodiver.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeProvider.of(context).theme.accentBackgroundColor,
        title: Text(
          AppLocalizations.of(context)!.pokemon,
          style: ThemeProvider.of(context).theme.appbarTextStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: ThemeProvider.of(context).theme.primaryBackgroundColor,
      ),
    );
  }
}
