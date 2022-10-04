import 'package:flutter/material.dart';
import 'package:pokemon_app/presentation/theme/pokemon_theme.dart';
import 'package:pokemon_app/core/ui/utils/pokemon_dimens.dart';

const theme = PokemonTheme(
  primaryColor: Colors.black54,
  primaryBackgroundColor: Colors.white,
  accentBackgroundColor: Colors.green,
  appbarTextStyle: TextStyle(
    color: Colors.black54,
    fontSize: PokemonDimens.sizeL,
  ),
  actionTextStyle: TextStyle(
    fontSize: PokemonDimens.sizeXXXXL,
    color: Colors.black38,
    fontWeight: FontWeight.w300,
  ),
);
