import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/core/ui/utils/string_ext.dart';
import 'package:pokemon_app/core/ui/widgets/pokemon_dialog.dart';
import 'package:pokemon_app/l10n/app_localizations.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_bloc.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_event.dart';
import 'package:pokemon_app/presentation/pages/main_page/bloc/main_state.dart';
import 'package:pokemon_app/presentation/pages/pokemon_page/pokemon_page.dart';
import 'package:pokemon_app/presentation/theme/theme_prodiver.dart';
import 'package:pokemon_app/presentation/widgets/pokemon_image.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<MainBloc>(context);
    _bloc.add(MainGetFirstPokemons());
    super.initState();
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
                                      PokemonImage(
                                        isOnline: state.isOnline,
                                        imgUrl: state.pokemons[index].imgUrl,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        height: MediaQuery.of(context).size.height * 0.3,
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
