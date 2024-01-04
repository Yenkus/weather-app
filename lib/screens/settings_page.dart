import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';
import 'package:weatherapp_starter_project/setting_stuf/themes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appTheme.primaryColor,
          title: const Text("Settings"),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
          color: appTheme.primaryColor,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Theme",
                  style: TextStyle(
                    color: appTheme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: AppStateContainer.of(context)
                      .theme
                      .colorScheme
                      .secondary
                      .withOpacity(0.1),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Dark",
                      style: TextStyle(color: appTheme.colorScheme.secondary),
                    ),
                    Radio<int>(
                      value: Themes.DARK_THEME_CODE,
                      groupValue: AppStateContainer.of(context).themeCode,
                      onChanged: (value) {
                        AppStateContainer.of(context).updateTheme(value!);
                      },
                      activeColor: appTheme.colorScheme.secondary,
                    )
                  ],
                ),
              ),
              Divider(
                color: appTheme.primaryColor,
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: AppStateContainer.of(context)
                      .theme
                      .colorScheme
                      .secondary
                      .withOpacity(0.1),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Light",
                      style: TextStyle(color: appTheme.colorScheme.secondary),
                    ),
                    Radio<int>(
                      value: Themes.LIGHT_THEME_CODE,
                      groupValue: AppStateContainer.of(context).themeCode,
                      onChanged: (value) {
                        AppStateContainer.of(context).updateTheme(value!);
                      },
                      activeColor: appTheme.colorScheme.secondary,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 8, right: 8, bottom: 8),
                child: Text(
                  "Unit",
                  style: TextStyle(
                    color: appTheme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: AppStateContainer.of(context)
                      .theme
                      .colorScheme
                      .secondary
                      .withOpacity(0.1),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Celsius",
                      style: TextStyle(color: appTheme.colorScheme.secondary),
                    ),
                    Radio<int>(
                      value: TemperatureUnit.celsius.index,
                      groupValue:
                          AppStateContainer.of(context).temperatureUnit.index,
                      onChanged: (value) {
                        AppStateContainer.of(context).updateTemperatureUnit(
                            TemperatureUnit.values[value!]);
                      },
                      activeColor: appTheme.colorScheme.secondary,
                    )
                  ],
                ),
              ),
              Divider(
                color: appTheme.primaryColor,
                height: 1,
              ),
              Container(
                color: AppStateContainer.of(context)
                    .theme
                    .colorScheme
                    .secondary
                    .withOpacity(0.1),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Fahrenheit",
                      style: TextStyle(color: appTheme.colorScheme.secondary),
                    ),
                    Radio<int>(
                      value: TemperatureUnit.fahrenheit.index,
                      groupValue:
                          AppStateContainer.of(context).temperatureUnit.index,
                      onChanged: (value) {
                        AppStateContainer.of(context).updateTemperatureUnit(
                            TemperatureUnit.values[value!]);
                      },
                      activeColor: appTheme.colorScheme.secondary,
                    )
                  ],
                ),
              ),
              Divider(
                color: appTheme.primaryColor,
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: AppStateContainer.of(context)
                      .theme
                      .colorScheme
                      .secondary
                      .withOpacity(0.1),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Kelvin",
                      style: TextStyle(color: appTheme.colorScheme.secondary),
                    ),
                    Radio(
                      value: TemperatureUnit.kelvin.index,
                      groupValue:
                          AppStateContainer.of(context).temperatureUnit.index,
                      onChanged: (value) {
                        // int val =
                        AppStateContainer.of(context).updateTemperatureUnit(
                            TemperatureUnit
                                .values[int.parse(value.toString())]);
                      },
                      activeColor: appTheme.colorScheme.secondary,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

// import 'package:flutter/material.dart';

// class WeatherSettingsPage extends StatefulWidget {
//   // receive the updateState function as an argument
//   final Function updateState;
//   const WeatherSettingsPage({super.key, required this.updateState});

//   @override
//   _WeatherSettingsPageState createState() => _WeatherSettingsPageState();
// }

// class _WeatherSettingsPageState extends State<WeatherSettingsPage> {
//   bool _isFahrenheit = true; // a flag to indicate the current temperature unit
//   bool _isDarkMode = false; // a flag to indicate the current theme mode

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Weather Settings'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Choose your preferred temperature unit:',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             const SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 // a toggle button for Fahrenheit
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isFahrenheit = true; // update the flag
//                     });
//                     // call the updateState function with the current values
//                     widget.updateState(_isDarkMode, _isFahrenheit);
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the button color based on the flag
//                         return _isFahrenheit
//                             ? Theme.of(context)
//                                 .colorScheme
//                                 .secondary // use the colorScheme property
//                             : Theme.of(context)
//                                 .colorScheme
//                                 .primary; // use the colorScheme property
//                       },
//                     ),
//                     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the text color based on the flag
//                         return _isFahrenheit ? Colors.white : Colors.black;
//                       },
//                     ),
//                   ),
//                   child: const Text('Fahrenheit'),
//                 ),
//                 // a toggle button for Celsius
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isFahrenheit = false; // update the flag
//                     });
//                     // call the updateState function with the current values
//                     widget.updateState(_isDarkMode, _isFahrenheit);
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the button color based on the flag
//                         return _isFahrenheit
//                             ? Theme.of(context)
//                                 .colorScheme
//                                 .primary // use the colorScheme property
//                             : Theme.of(context)
//                                 .colorScheme
//                                 .secondary; // use the colorScheme property
//                       },
//                     ),
//                     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the text color based on the flag
//                         return _isFahrenheit ? Colors.black : Colors.white;
//                       },
//                     ),
//                   ),
//                   child: const Text('Celsius'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20.0),
//             const Text(
//               'Choose your preferred theme mode:',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             const SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 // a toggle button for light mode
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isDarkMode = false; // update the flag
//                     });
//                     // call the updateState function with the current values
//                     widget.updateState(_isDarkMode, _isFahrenheit);
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the button color based on the flag
//                         return _isDarkMode
//                             ? Theme.of(context)
//                                 .colorScheme
//                                 .primary // use the colorScheme property
//                             : Theme.of(context)
//                                 .colorScheme
//                                 .secondary; // use the colorScheme property
//                       },
//                     ),
//                     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the text color based on the flag
//                         return _isDarkMode ? Colors.black : Colors.white;
//                       },
//                     ),
//                   ),
//                   child: const Text('Light'),
//                 ),
//                 // a toggle button for dark mode
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isDarkMode = true; // update the flag
//                     });
//                     // call the updateState function with the current values
//                     widget.updateState(_isDarkMode, _isFahrenheit);
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the button color based on the flag
//                         return _isDarkMode
//                             ? Theme.of(context)
//                                 .colorScheme
//                                 .secondary // use the colorScheme property
//                             : Theme.of(context)
//                                 .colorScheme
//                                 .primary; // use the colorScheme property
//                       },
//                     ),
//                     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the text color based on the flag
//                         return _isDarkMode ? Colors.white : Colors.black;
//                       },
//                     ),
//                   ),
//                   child: const Text('Dark'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class WeatherSettingsPage extends StatefulWidget {
//   // receive the updateState function as an argument
//   final Function updateState;
//   const WeatherSettingsPage({Key? key, required this.updateState})
//       : super(key: key);

//   @override
//   _WeatherSettingsPageState createState() => _WeatherSettingsPageState();
// }
// class _WeatherSettingsPageState extends State<WeatherSettingsPage> {
//   bool _isFahrenheit = true; // a flag to indicate the current temperature unit
//   bool _isDarkMode = false; // a flag to indicate the current theme mode

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather Settings'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Choose your preferred temperature unit:',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 // a toggle button for Fahrenheit
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isFahrenheit = true; // update the flag
//                     });
//                     // call the updateState function with the current values
//                     widget.updateState(_isDarkMode, _isFahrenheit);
//                   },
//                   child: Text('Fahrenheit'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the button color based on the flag
//                         return _isFahrenheit
//                             ? Theme.of(context).accentColor
//                             : Theme.of(context).primaryColor;
//                       },
//                     ),
//                     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the text color based on the flag
//                         return _isFahrenheit ? Colors.white : Colors.black;
//                       },
//                     ),
//                   ),
//                 ),
//                 // a toggle button for Celsius
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isFahrenheit = false; // update the flag
//                     });
//                     // call the updateState function with the current values
//                     widget.updateState(_isDarkMode, _isFahrenheit);
//                   },
//                   child: Text('Celsius'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the button color based on the flag
//                         return _isFahrenheit
//                             ? Theme.of(context).primaryColor
//                             : Theme.of(context).accentColor;
//                       },
//                     ),
//                     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the text color based on the flag
//                         return _isFahrenheit ? Colors.black : Colors.white;
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               'Choose your preferred theme mode:',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 // a toggle button for light mode
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isDarkMode = false; // update the flag
//                     });
//                     // call the updateState function with the current values
//                     widget.updateState(_isDarkMode, _isFahrenheit);
//                   },
//                   child: Text('Light'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the button color based on the flag
//                         return _isDarkMode
//                             ? Theme.of(context).primaryColor
//                             : Theme.of(context).accentColor;
//                       },
//                     ),
//                     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the text color based on the flag
//                         return _isDarkMode ? Colors.black : Colors.white;
//                       },
//                     ),
//                   ),
//                 ),
//                 // a toggle button for dark mode
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isDarkMode = true; // update the flag
//                     });
//                     // call the updateState function with the current values
//                     widget.updateState(_isDarkMode, _isFahrenheit);
//                   },
//                   child: Text('Dark'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the button color based on the flag
//                         return _isDarkMode
//                             ? Theme.of(context).accentColor
//                             : Theme.of(context).primaryColor;
//                       },
//                     ),
//                     foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                       (Set<MaterialState> states) {
//                         // change the text color based on the flag
//                         return _isDarkMode ? Colors.white : Colors.black;
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//      ),
// );
// }
// }
