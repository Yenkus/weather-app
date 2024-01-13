import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/screens/city_manager.dart';
import 'package:weatherapp_starter_project/screens/home.dart';
import 'package:weatherapp_starter_project/screens/settings_page.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/home': (context) => const HomeScreen(),
    '/settings': (context) => const SettingsScreen(),
    '/menu': (context) => const WeatherCityManagerPage(),
  };
}
