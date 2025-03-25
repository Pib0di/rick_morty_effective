import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_effective/ui/common/widgets/character_card.dart';
import 'package:rick_morty_effective/ui/pages/home/bloc/home_cubit.dart';

import '../../../core/bloc/app_cubit.dart';

class FavouritePage extends StatefulWidget {
  static const routeName = '/favorite';

  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late final AppCubit _appCubit;
  late final HomeCubit _homeCubit;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    _homeCubit = context.read();
    _appCubit = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite'),
        actions: [
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () => setState(() {
                  _appCubit.toggleTheme();
                }),
                icon: Icon(
                  _appCubit.state.themeMode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.dark_mode_rounded,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _homeCubit.sortFavoritesByName,
        child: Icon(Icons.sort),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: _homeCubit,
          builder: (context, homeState) {
            return ListView.builder(
              itemCount: homeState.favorites?.length ?? 0,
              itemBuilder: (context, index) {
                final item = homeState.favorites![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CharacterCard(
                    item: item,
                    isFavorite: homeState.isFavoriteMap?[item.id] ?? false,
                    onPressed: () {
                      _homeCubit.saveOrDeleteFavorite(item);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
