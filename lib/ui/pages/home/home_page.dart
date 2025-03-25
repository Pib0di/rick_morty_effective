import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_morty_effective/ui/common/widgets/character_card.dart';

import '../../../core/bloc/app_cubit.dart';
import '../../../core/model/character.dart';
import 'bloc/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit _homeCubit;
  late final AppCubit _appCubit;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    _homeCubit = context.read()..getAllFavorite();
    _appCubit = context.read();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, appState) {
            return BlocBuilder<HomeCubit, HomeState>(
              builder: (context, homeState) {
                return PagingListener(
                  controller: _homeCubit.pagingController,
                  builder: (context, state, fetchNextPage) => PagedListView<int, Results>(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate(
                      noMoreItemsIndicatorBuilder: (_) => Center(child: Text('No more items')),
                      itemBuilder: (context, item, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: CharacterCard(
                          item: item,
                          isFavorite: homeState.isFavoriteMap?[item.id] ?? false,
                          onPressed: () {
                            _homeCubit.saveOrDeleteFavorite(item);
                          },
                        ),
                      ),
                    ),
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
