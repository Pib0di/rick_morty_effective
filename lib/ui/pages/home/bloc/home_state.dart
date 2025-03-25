part of 'home_cubit.dart';

@immutable
class HomeState {
  final Characters? characters;
  final List<Results>? favorites;
  final Map<int, bool>? isFavoriteMap;
  final bool isSortedByName;

  const HomeState({
    this.characters,
    this.favorites,
    this.isFavoriteMap,
    this.isSortedByName = false,
  });

  HomeState copyWith({
    Characters? characters,
    List<Results>? favorites,
    Map<int, bool>? isFavoriteMap,
    bool? isSortedByName,
  }) {
    return HomeState(
      characters: characters ?? this.characters,
      favorites: favorites ?? this.favorites,
      isFavoriteMap: isFavoriteMap ?? this.isFavoriteMap,
      isSortedByName: isSortedByName ?? this.isSortedByName,
    );
  }
}

final class HomeInitial extends HomeState {}
