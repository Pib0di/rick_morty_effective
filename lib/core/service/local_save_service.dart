import 'dart:convert';

import 'package:rick_morty_effective/core/model/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logger.dart';

const String KEY_FAVORITE = 'KEY_FAVORITE';

class LocalSaveService {
  static Future<void> saveOrDeleteFavorite(Results character) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(KEY_FAVORITE) ?? [];

    final characterExists = favorites.any((item) => jsonDecode(item)['id'] == character.id);

    if (characterExists) {
      favorites.removeWhere((item) => jsonDecode(item)['id'] == character.id);
      logger.d('Deleted favorite: ${character.name}');
    } else {
      favorites.add(jsonEncode(character.toJson()));
      logger.d('Saved favorite: ${character.name}');
    }

    await prefs.setStringList(KEY_FAVORITE, favorites);
  }

  static Future<List<Results>> getAllFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(KEY_FAVORITE) ?? [];

    return favorites.map((item) => Results.fromJson(jsonDecode(item))).toList();
  }
}
