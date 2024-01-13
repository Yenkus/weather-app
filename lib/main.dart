import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/data/city_provider.dart';
import 'package:weatherapp_starter_project/screens/routes.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import './screens/home.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => CityProvider())],
    child: const AppStateContainer(child: MyApp()),
  ));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: AppStateContainer.of(context).theme,
      home: const HomeScreen(),
      routes: Routes.mainRoute,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import './screens/home.dart';

// void main() {
//   runApp( AppStateContainer(
// child: const MyApp()));
// }

// class MyApp extends StatelessWidget {
// const MyApp({Key? key}) 
// : super(key: key);

// @override 
// Widget build(BuildContext context) {
//     return MaterialApp(
// debugShowCheckedModeBanner: false,
// title: ' Weather App',
//       theme: AppStateContainer.of(context).theme,
// home: HomeScreen(),
// routes: Routes.mainRoute,
//     );
//   }
// }

// /// top level widget to hold application state
// /// state is passed down with an inherited widget
// /// inherited widget state is mainly used to hold app theme and temerature unit
// class AppStateContainer extends StatefulWidget {
//   final Widget child;

//   AppStateContainer({@required this.child});

//   @override
//   _AppStateContainerState createState() => _AppStateContainerState();

//   static _AppStateContainerState of(BuildContext context) {
//     var widget =
//         context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>();
//     return widget.data;
//   }
// }

// class _AppStateContainerState extends State<AppStateContainer> {
//   ThemeData _theme = Themes.getTheme(Themes.DARK_THEME_CODE);
//   int themeCode = Themes.DARK_THEME_CODE;
//   TemperatureUnit temperatureUnit = TemperatureUnit.celsius;

//   @override
//   initState() {
//     super.initState();
//     SharedPreferences.getInstance().then((sharedPref) {
//       setState(() {
//         themeCode = sharedPref.getInt(CONSTANTS.SHARED_PREF_KEY_THEME) ??
//             Themes.DARK_THEME_CODE;
//         temperatureUnit = TemperatureUnit.values[
//             sharedPref.getInt(CONSTANTS.SHARED_PREF_KEY_TEMPERATURE_UNIT) ??
//                 TemperatureUnit.celsius.index];
//         this._theme = Themes.getTheme(themeCode);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(theme.accentColor);
//     return _InheritedStateContainer(
//       data: this,
//       child: widget.child,
//     );
//   }

//   ThemeData get theme => _theme;

//   updateTheme(int themeCode) {
//     setState(() {
//       _theme = Themes.getTheme(themeCode);
//       this.themeCode = themeCode;
//     });
//     SharedPreferences.getInstance().then((sharedPref) {
//       sharedPref.setInt(CONSTANTS.SHARED_PREF_KEY_THEME, themeCode);
//     });
//   }

//   updateTemperatureUnit(TemperatureUnit unit) {
//     setState(() {
//       this.temperatureUnit = unit;
//     });
//     SharedPreferences.getInstance().then((sharedPref) {
//       sharedPref.setInt(CONSTANTS.SHARED_PREF_KEY_TEMPERATURE_UNIT, unit.index);
//     });
//   }
// }

// class _InheritedStateContainer extends InheritedWidget {
//   final _AppStateContainerState data;

//   const _InheritedStateContainer({
//     Key key,
//     @required this.data,
//     @required Widget child,
//   }) : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
// }
