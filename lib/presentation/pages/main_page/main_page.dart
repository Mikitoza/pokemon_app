import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/injector.dart';
import 'package:pokemon_app/l10n/app_localizations.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_bloc.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_event.dart';
import 'package:pokemon_app/presentation/pages/main_page/main_state.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/pokemon_page.dart';
import 'package:pokemon_app/presentation/theme/theme_prodiver.dart';
import 'package:pokemon_app/presentation/utils/image_util.dart';
import 'package:pokemon_app/presentation/utils/string_ext.dart';
import 'package:pokemon_app/presentation/widgets/pokemon_dialog.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _bloc = locator.get<MainBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(MainGetFirstPokemons());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
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
          backgroundColor: ThemeProvider.of(context).theme.accentBackgroundColor,
          title: Text(
            AppLocalizations.of(context)!.pokemon,
            style: ThemeProvider.of(context).theme.appbarTextStyle,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: state.status.isInitial || state.status.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification) {
                              if (notification.metrics.pixels ==
                                      notification.metrics.maxScrollExtent &&
                                  !state.isLoadingMore &&
                                  state.isOnline) {
                                _bloc.add(
                                  MainLoadMorePokemons(_bloc.state.page * 20, _bloc.state.limit),
                                );
                              }
                            }
                            return true;
                          },
                          child: ListView.builder(
                            itemCount: state.pokemons.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PokemonPage(
                                      id: state.pokemons[index].id,
                                      isOnline: state.isOnline,
                                    ),
                                  ),
                                ),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: Column(
                                    children: [
                                      state.isOnline
                                          ? Image.network(
                                              state.pokemons[index].imgUrl,
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              height: MediaQuery.of(context).size.height * 0.3,
                                              fit: BoxFit.fill,
                                              frameBuilder: (BuildContext context, Widget child,
                                                      int? frame, bool wasSynchronouslyLoaded) =>
                                                  wasSynchronouslyLoaded
                                                      ? child
                                                      : AnimatedOpacity(
                                                          opacity: frame == null ? 0 : 1,
                                                          duration: const Duration(seconds: 2),
                                                          curve: Curves.easeOut,
                                                          child: child,
                                                        ),
                                              loadingBuilder: (context, child, progress) =>
                                                  progress == null
                                                      ? child
                                                      : const CircularProgressIndicator(),
                                              errorBuilder: (BuildContext context, Object exception,
                                                      StackTrace? stackTrace) =>
                                                  const Text('Failed to load image'),
                                            )
                                          : Image.memory(
                                              Utility.dataFromBase64String(
                                                state.pokemons[index].imgUrl,
                                              ),
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              height: MediaQuery.of(context).size.height * 0.3,
                                              fit: BoxFit.fill,
                                            ),
                                      Text(
                                        state.pokemons[index].title.fromBigChar(),
                                        style: ThemeProvider.of(context).theme.actionTextStyle,
                                      ),
                                      const SizedBox(height: 16)
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                    if (state.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
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
