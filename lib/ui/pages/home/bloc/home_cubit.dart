import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty_effective/core/model/character.dart';
import 'package:rick_morty_effective/core/service/local_save_service.dart';

import '../../../../core/bloc/app_cubit.dart';
import '../../../../core/repository/content_repository.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/tools/mixin.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with StartStopLoading {
  HomeCubit(this._contentRepository, this._appBloc) : super(HomeInitial()) {
    init();
  }

  late final PagingController<int, Results> _pagingController;
  final ContentRepository _contentRepository;
  final AppCubit _appBloc;

  PagingController<int, Results> get pagingController => _pagingController;

  @override
  AppCubit get appBloc => _appBloc;

  init() {
    _pagingController = PagingController<int, Results>(
      getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
      fetchPage: (pageKey) async {
        final characters = await getCharacters(pageKey);
        if (pageKey > (characters?.info?.pages ?? 0)) {
          return [];
        }

        return characters?.results ?? [];
      },
    );
  }

  FutureOr<Characters?> getCharacters(int page) async {
    startLoading();

    final result = await _contentRepository.getCharacters(page: page);

    emit(state.copyWith(characters: result));

    stopLoading();

    return result;
  }

  Future<void> saveOrDeleteFavorite(Results character) async {
    try {
      await LocalSaveService.saveOrDeleteFavorite(character);

      getAllFavorite();
    } catch (e) {
      logger.d('Error saving favorite: $e');
    }
  }

  Future<void> getAllFavorite() async {
    final result = await LocalSaveService.getAllFavorite();

    final isFavoriteMap = {for (var item in result) item.id ?? -1: true};
    emit(state.copyWith(favorites: result, isFavoriteMap: isFavoriteMap));
  }

  void sortFavoritesByName() {
    if (state.favorites == null) return;

    final sortedFavorites = List<Results>.from(state.favorites!)
      ..sort((a, b) {
        if (state.isSortedByName) {
          // Обратный порядок (Z-A)
          if (a.name == null && b.name == null) return 0;
          if (a.name == null) return 1;
          if (b.name == null) return -1;
          return b.name!.compareTo(a.name!);
        } else {
          // Прямой порядок (A-Z)
          if (a.name == null && b.name == null) return 0;
          if (a.name == null) return -1;
          if (b.name == null) return 1;
          return a.name!.compareTo(b.name!);
        }
      });

    emit(state.copyWith(favorites: sortedFavorites, isSortedByName: !state.isSortedByName));
  }
}
