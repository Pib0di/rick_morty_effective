import 'package:flutter/material.dart';

ThemeData makeAppTheme({bool isDark = false}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: isDark ? Brightness.dark : Brightness.light,
  );

  final baseTheme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      color: isDark ? Colors.black : Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: isDark ? Colors.white : Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textColor: colorScheme.onSecondaryContainer,
      iconColor: colorScheme.onSecondaryContainer,
      tileColor: colorScheme.secondaryContainer,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: Colors.amber,
      ),
    ),
  );

  return baseTheme;
}
