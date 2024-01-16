import 'package:flutter/material.dart';

class Themes {
  static const DARK_THEME_CODE = 0;
  static const LIGHT_THEME_CODE = 1;

  static final _dark = ThemeData(
      disabledColor: Colors.green,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
        Colors.black.value,
        const <int, Color>{
          // 50: Colors.black12,
          // 100: Colors.black26,
          // 200: Colors.black38,
          // 300: Colors.black45,
          // 400: Colors.black54,
          // 500: Colors.black87,
          // 600: Colors.black87,
          // 700: Colors.black87,
          // 800: Colors.black87,
          // 900: Colors.black87,
          50: Colors.black12,
          100: Colors.black26,
          200: Colors.black87,
          300: Colors.black45,
          400: Colors.black54,
          500: Colors.black87,
          600: Colors.black87,
          700: Colors.black87,
          800: Colors.black87,
          900: Colors.black87,
          // 50: Colors.white10,
          // 100: Colors.white12,
          // 200: Colors.white24,
          // 300: Colors.white30,
          // 400: Colors.white54,
          // 500: Colors.white70,
          // 600: Colors.white70,
          // 700: Colors.white70,
          // 800: Colors.white70,
          // 900: Colors.white70,
        },
      )).copyWith(secondary: Colors.white));

  final mlight = ThemeData.dark();
  static final _light = ThemeData(
      disabledColor: Colors.green,
      // scaffoldBackgroundColor: ,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
        Colors.white.value,
        const <int, Color>{
          50: Colors.white10,
          100: Colors.white12,
          // 200 controls scaffold
          200: Colors.white,
          300: Colors.white30,
          400: Colors.white54,
          500: Colors.white70,
          600: Colors.white70,
          700: Colors.white70,
          800: Colors.white70,
          900: Colors.white70,

          // 50: Colors.red,
          // 100: Colors.pink,
          // 200: Colors.blue,
          // 300: Colors.yellow,
          // 400: Colors.green,
          // 500: Colors.brown,
          // 600: Colors.purple,
          // 700: Colors.orange,
          // 800: Colors.white70,
        },
      )).copyWith(secondary: Colors.black));

  // static ThemeData getTheme(int code) {
  //   if (code == LIGHT_THEME_CODE) {
  //     return _light;
  //   }
  //   return _dark;
  // }
  static ThemeData getTheme(int code) {
    if (code == DARK_THEME_CODE) {
      return _dark;
    }
    return _light;
  }
}
