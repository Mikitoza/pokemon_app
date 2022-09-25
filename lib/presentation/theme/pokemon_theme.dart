import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

class PokemonTheme extends Equatable {
  final Color primaryColor;
  final Color primaryBackgroundColor;
  final Color accentBackgroundColor;
  final TextStyle appbarTextStyle;
  final TextStyle actionTextStyle;

  const PokemonTheme({
    required this.primaryColor,
    required this.primaryBackgroundColor,
    required this.accentBackgroundColor,
    required this.appbarTextStyle,
    required this.actionTextStyle,
  });

  @override
  List<Object?> get props => [
        primaryColor,
        primaryBackgroundColor,
        accentBackgroundColor,
        appbarTextStyle,
        actionTextStyle,
      ];
}
