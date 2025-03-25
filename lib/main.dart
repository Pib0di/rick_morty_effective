// ЗАДАНИЕ:
// Реализуйте экран ProductListScreen, выводящий товары из списка products.
// Выведите для каждого товара название, описание и цену.
// Оформите UI по своему усмотрению.
import 'package:flutter/material.dart';
import 'package:rick_morty_effective/core/dependencies/provider_scope.dart';
import 'package:rick_morty_effective/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(child: const MyApp()),
  );
}
