import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/constant/constant.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp_starter_project/setting_stuf/themes.dart';

/// top level widget to hold application state
/// state is passed down with an inherited widget
/// inherited widget state is mainly used to hold app theme and temerature unit
class AppStateContainer extends StatefulWidget {
  final Widget child;

  const AppStateContainer({super.key, required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    var widget =
        context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>();
    return widget!.data;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
  ThemeData _theme = Themes.getTheme(Themes.DARK_THEME_CODE);
  int themeCode = Themes.DARK_THEME_CODE;
  // ThemeData _theme = Themes.getTheme(Themes.LIGHT_THEME_CODE);
  // int themeCode = Themes.LIGHT_THEME_CODE;
  TemperatureUnit temperatureUnit = TemperatureUnit.celsius;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      setState(() {
        themeCode = sharedPref.getInt(CONSTANTS.SHARED_PREF_KEY_THEME) ??
            Themes.LIGHT_THEME_CODE;
        temperatureUnit = TemperatureUnit.values[
            sharedPref.getInt(CONSTANTS.SHARED_PREF_KEY_TEMPERATURE_UNIT) ??
                TemperatureUnit.celsius.index];
        _theme = Themes.getTheme(themeCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(theme.colorScheme.secondary);
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  ThemeData get theme => _theme;

  updateTheme(int themeCode) {
    setState(() {
      _theme = Themes.getTheme(themeCode);
      this.themeCode = themeCode;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(CONSTANTS.SHARED_PREF_KEY_THEME, themeCode);
    });
  }

  updateTemperatureUnit(TemperatureUnit unit) {
    setState(() {
      temperatureUnit = unit;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(CONSTANTS.SHARED_PREF_KEY_TEMPERATURE_UNIT, unit.index);
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  const _InheritedStateContainer({
    super.key,
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;

  static _AppStateContainerState of(BuildContext context) {
    var widget =
        context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>();
    return widget!.data;
  }
}

class TemperatureFormatter {
  static String getFormattedTemperature(int temperature, TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return '$temperature°C';
      case TemperatureUnit.fahrenheit:
        int fahrenheitTemperature = ((temperature * 9 / 5) + 32).round();
        return '$fahrenheitTemperature°F';
      case TemperatureUnit.kelvin:
        double kelvinTemperature = temperature + 273.15;
        return '${kelvinTemperature.toStringAsFixed(2)}K';
    }
  }
}
