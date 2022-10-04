import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/core/injector.dart';
import 'package:pokemon_app/core/ui/utils/string_ext.dart';
import 'package:pokemon_app/core/ui/widgets/pokemon_dialog.dart';
import 'package:pokemon_app/l10n/app_localizations.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/bloc/pokemon_bloc.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/bloc/pokemon_event.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/bloc/pokemon_state.dart';
import 'package:pokemon_app/presentation/theme/theme_prodiver.dart';
import 'package:pokemon_app/presentation/widgets/pokemon_image.dart';

class PokemonPage extends StatefulWidget {
  final int id;
  final bool isOnline;
  const PokemonPage({
    Key? key,
    required this.id,
    required this.isOnline,
  }) : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  late final PokemonBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = locator.get<PokemonBloc>();
    _bloc.add(
      PokemonInitialize(
        id: widget.id,
        isOnline: widget.isOnline,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonBloc, PokemonState>(
      bloc: _bloc,
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) async {
        if (state.status.isError) {
          _showMyDialog(state.errorDesc);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          actions: [
            if (widget.isOnline)
              IconButton(
                onPressed: () => _bloc.add(
                  PokemonSave(id: widget.id),
                ),
                icon: const Icon(Icons.save),
              ),
          ],
          backgroundColor: ThemeProvider.of(context).theme.accentBackgroundColor,
          title: Text(
            state.status.isLoading || state.status.isInitial
                ? AppLocalizations.of(context)!.loading
                : state.name.fromBigChar(),
            style: ThemeProvider.of(context).theme.appbarTextStyle,
          ),
          centerTitle: true,
          leading: BackButton(
            color: ThemeProvider.of(context).theme.primaryColor,
          ),
        ),
        body: Center(
          child: state.status.isInitial || state.status.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    PokemonImage(
                      isOnline: widget.isOnline,
                      imgUrl: state.image,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    _textLabel(AppLocalizations.of(context)!.pokemonName(state.name.fromBigChar())),
                    _textLabel(
                      AppLocalizations.of(context)!.pokemonTypes(
                        state.types.map((type) => type.fromBigChar()).join(', '),
                      ),
                    ),
                    _textLabel(AppLocalizations.of(context)!.pokemonHeight(state.height)),
                    _textLabel(AppLocalizations.of(context)!.pokemonWeight(state.weight)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _textLabel(String text) {
    return Text(
      text,
      style: ThemeProvider.of(context).theme.actionTextStyle,
    );
  }

  Future<void> _showMyDialog(String desc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PokemonDialog(
          desc: desc,
        );
      },
    );
  }
}
