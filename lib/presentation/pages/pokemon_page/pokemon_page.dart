import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/injector.dart';
import 'package:pokemon_app/l10n/app_localizations.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/pokemon_bloc.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/pokemon_event.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/pokemon_state.dart';
import 'package:pokemon_app/presentation/theme/theme_prodiver.dart';
import 'package:pokemon_app/presentation/utils/image_util.dart';
import 'package:pokemon_app/presentation/utils/string_ext.dart';
import 'package:pokemon_app/presentation/widgets/pokemon_dialog.dart';

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
  final _bloc = locator.get<PokemonBloc>();

  @override
  void initState() {
    super.initState();
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
                    widget.isOnline
                        ? Image.network(
                            state.image,
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.5,
                            fit: BoxFit.fill,
                            frameBuilder: (BuildContext context, Widget child, int? frame,
                                    bool wasSynchronouslyLoaded) =>
                                wasSynchronouslyLoaded
                                    ? child
                                    : AnimatedOpacity(
                                        opacity: frame == null ? 0 : 1,
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.easeOut,
                                        child: child,
                                      ),
                            loadingBuilder: (context, child, progress) =>
                                progress == null ? child : const CircularProgressIndicator(),
                            errorBuilder:
                                (BuildContext context, Object exception, StackTrace? stackTrace) =>
                                    const Text('Failed to load image'),
                          )
                        : Image.memory(
                            Utility.dataFromBase64String(
                              state.image,
                            ),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.fill,
                          ),
                    Text(
                      AppLocalizations.of(context)!.pokemonName(state.name.fromBigChar()),
                      style: ThemeProvider.of(context).theme.actionTextStyle,
                    ),
                    Text(
                      AppLocalizations.of(context)!.pokemonTypes(
                        state.types.map((type) => type.fromBigChar()).join(', '),
                      ),
                      style: ThemeProvider.of(context).theme.actionTextStyle,
                    ),
                    Text(
                      AppLocalizations.of(context)!.pokemonHeight(state.height),
                      style: ThemeProvider.of(context).theme.actionTextStyle,
                    ),
                    Text(
                      AppLocalizations.of(context)!.pokemonWeight(state.weight),
                      style: ThemeProvider.of(context).theme.actionTextStyle,
                    ),
                  ],
                ),
        ),
      ),
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
