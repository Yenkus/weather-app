import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/models/weather_data.dart';
import 'package:weatherapp_starter_project/provider/city_provider.dart';
import 'package:weatherapp_starter_project/screens/city_manager.dart';
import 'package:weatherapp_starter_project/screens/settings_page.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';
import 'package:weatherapp_starter_project/util/custom_colors.dart';
import '../controller/global_controller.dart';
import '../widget/Sun_Info.dart';
import '../widget/daily_forecast.dart';
import '../widget/heder.dart';
import '../widget/current_weather.dart';
import '../widget/Hourly_data_widger.dart';
import '../widget/ComfortLevel.dart';

// Import the package
import 'package:anim_search_bar/anim_search_bar.dart';

// Create a text controller
TextEditingController textController = TextEditingController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create a global controller
  final globalcontroller = Get.put(GlobalController(), permanent: true);
  // Create a variable for the city name
  String city = "";
  // Create a variable for the fetch data instance
  FetchData? fetchData;
  @override
  Widget build(BuildContext context) {
    // Your existing HomeScreen implementation
    // Make sure to use AppStateContainer.of(context) to access the theme and temperature unit

    ThemeData appTheme = AppStateContainer.of(context).theme;
    TemperatureUnit temperatureUnit =
        AppStateContainer.of(context).temperatureUnit;

    // Debugging: Print retrieved data
    print("Theme: $appTheme");
    print("Temperature Unit: $temperatureUnit");

    // Rest of your HomeScreen code
    return Consumer<CityProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: appTheme.primaryColor,
          // backgroundColor: CustomColors.firstGradientColor,
          title: Text(
            'My Weather',
            style: TextStyle(color: appTheme.colorScheme.secondary),
          ),
          // title: const Text('My Weather'),
          actions: (value.hasDataLoaded == true)
              ? [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityManagerPage()));
                    },
                    icon: Icon(
                      Icons.menu,
                      color: appTheme.colorScheme.secondary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()));
                    },
                    icon: Icon(
                      Icons.settings,
                      color: appTheme.colorScheme.secondary,
                    ),
                  ),
                ]
              : [
                  // Show nothing when weather data hasn't loaded
                ],
        ),
        body: Obx(
          // Use the city parameter to display the weather data
          (city) => globalcontroller.checkStatus().isTrue
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/clouds.png'),
                        const SizedBox(
                          height: 10,
                        ),
                        const CircularProgressIndicator(),
                      ]),
                )
              : FutureBuilder<WeatherData>(
                  // Use the fetchData instance to get the weather data
                  future: fetchData?.getData(),
                  // Use a snapshot function to display different widgets
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Display the list of widgets with the weather data
                      return ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          // Use the anim_search_bar widget
                          AnimSearchBar(
                            width: 400,
                            textController: textController,
                            onSuffixTap: () {
                              // Get the city name from the text controller
                              String city = textController.text;
                              // Call the getCity function with the city name
                              getCity(city);
                              // Clear the text controller
                              textController.clear();
                            },
                            // Use the onCityChanged callback function to pass the city name
                            onCityChanged: (city) {
                              // Update the weather data based on the city name
                              globalcontroller.updateWeatherData(city);
                            },
                          ),
                          CurrentWeatherWidget(
                              snapshot.data!.weatherDataCurrent),
                          const SizedBox(
                            height: 20,
                          ),
                          HourlyDataWidget(snapshot.data!.weatherDataHourly),
                          SunInfo(snapshot.data!.weatherDataCurrent),
                          DailyForecast(snapshot.data!.weatherDataDaily),
                          const Divider(),
                          ComfortLevel(snapshot.data!.weatherDataCurrent),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      // Display the error message
                      return Text(
                        'Something went wrong: ${snapshot.error}',
                        style: TextStyle(color: appTheme.colorScheme.secondary),
                      );
                    } else {
                      // Display a loading indicator
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
        ),
      );
    });
  }
}

// Define the getCity function
getCity(city) async {
  // Use the city name to get the coordinates from the BigDataCloud API
  final url = Uri.parse(
      'https://api.bigdatacloud.net/data/reverse-geocode-client?locality=$city&localityLanguage=en');
  final response = await http.get(url);
  final data = jsonDecode(response.body);

  // Get the coordinates from the data
  double lat = data["latitude"];
  double lng = data["longitude"];

  // Create a fetchData instance with the coordinates
  fetchData = FetchData(lat, lng);
  // Update the city variable
  setState(() {
    this.city = city;
  });
}


// Commented on the 18th of January 2024
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final globalcontroller = Get.put(GlobalController(), permanent: true);
//   @override
//   Widget build(BuildContext context) {
//     // Your existing HomeScreen implementation
//     // Make sure to use AppStateContainer.of(context) to access the theme and temperature unit

//     ThemeData appTheme = AppStateContainer.of(context).theme;
//     TemperatureUnit temperatureUnit =
//         AppStateContainer.of(context).temperatureUnit;

//     // Debugging: Print retrieved data
//     print("Theme: $appTheme");
//     print("Temperature Unit: $temperatureUnit");

//     // Rest of your HomeScreen code
//     return Consumer<CityProvider>(builder: (context, value, child) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: appTheme.primaryColor,
//           // backgroundColor: CustomColors.firstGradientColor,
//           title: Text(
//             'My Weather',
//             style: TextStyle(color: appTheme.colorScheme.secondary),
//           ),
//           // title: const Text('My Weather'),
//           actions: (value.hasDataLoaded == true)
//               ? [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const CityManagerPage()));
//                     },
//                     icon: Icon(
//                       Icons.menu,
//                       color: appTheme.colorScheme.secondary,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SettingsScreen()));
//                     },
//                     icon: Icon(
//                       Icons.settings,
//                       color: appTheme.colorScheme.secondary,
//                     ),
//                   ),
//                 ]
//               : [
//                   // Show nothing when weather data hasn't loaded
//                 ],
//         ),
//         body: Obx(
//           () => globalcontroller.checkStatus().isTrue
//               ? Center(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset('assets/icons/clouds.png'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const CircularProgressIndicator(),
//                       ]),
//                 )
//               : ListView(
//                   scrollDirection: Axis.vertical,
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const HeaderSc(),
//                     CurrentWeatherWidget(
//                         globalcontroller.getWeatherData().weatherDataCurrent()),
//                     //globalcontroller.getWeatherData().weatherDataCurrent()),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     HourlyDataWidget(
//                       weatherDataHourly:
//                           globalcontroller.getWeatherData().weatherDataHourly(),
//                     ),
//                     SunInfo(
//                         weatherDataCurrent: globalcontroller
//                             .getWeatherData()
//                             .weatherDataCurrent()),
//                     DailyForecast(
//                       weatherDataDaily:
//                           globalcontroller.getWeatherData().weatherDataDaily(),
//                     ),
//                     const Divider(),
//                     ComfortLevel(
//                       weatherDataCurrent: globalcontroller
//                           .getWeatherData()
//                           .weatherDataCurrent(),
//                     )
//                   ],
//                 ),
//         ),
//       );
//     });
//   }
// }

// commented on the 11th of January 2024
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final globalcontroller = Get.put(GlobalController(), permanent: true);
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CityProvider>(builder: (context, value, child) {
//       return Scaffold(
//           appBar: AppBar(
//             backgroundColor: CustomColors.firstGradientColor,
//             title: const Text(
//               'My Weather',
//               style: TextStyle(color: Colors.white),
//             ),
//             // title: const Text('My Weather'),
//             actions: (value.hasDataLoaded == true)
//                 ? [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>  CityManagerPage()));
//                       },
//                       icon: const Icon(
//                         Icons.menu,
//                         color: Colors.white,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SettingsScreen()));
//                       },
//                       icon: const Icon(
//                         Icons.settings,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ]
//                 : [
//                     // Show nothing when weather data hasn't loaded
//                   ],
//           ),
//           body: Obx(() => globalcontroller.checkStatus().isTrue
//               ? Center(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset('assets/icons/clouds.png'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const CircularProgressIndicator(),
//                       ]),
//                 )
//               : ListView(
//                   scrollDirection: Axis.vertical,
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const HeaderSc(),
//                     CurrentWeatherWidget(
//                         globalcontroller.getWeatherData().weatherDataCurrent()),
//                     //globalcontroller.getWeatherData().weatherDataCurrent()),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     HourlyDataWidget(
//                       weatherDataHourly:
//                           globalcontroller.getWeatherData().weatherDataHourly(),
//                     ),
//                     SunInfo(
//                         weatherDataCurrent: globalcontroller
//                             .getWeatherData()
//                             .weatherDataCurrent()),
//                     DailyForecast(
//                       weatherDataDaily:
//                           globalcontroller.getWeatherData().weatherDataDaily(),
//                     ),
//                     const Divider(),
//                     ComfortLevel(
//                       weatherDataCurrent: globalcontroller
//                           .getWeatherData()
//                           .weatherDataCurrent(),
//                     )
//                   ],
//                 )));
//     });
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
// import 'package:weatherapp_starter_project/data/city_provider.dart';
// import 'package:weatherapp_starter_project/screens/city_manager.dart';
// // import 'package:openweathermap/openweathermap.dart';
// import 'package:weatherapp_starter_project/screens/settings_page.dart';
// import 'package:weatherapp_starter_project/util/custom_colors.dart';
// import '../controller/global_controller.dart';
// import '../widget/Sun_Info.dart';
// import '../widget/daily_forecast.dart';
// import '../widget/heder.dart';
// import '../widget/current_weather.dart';
// import '../widget/Hourly_data_widger.dart';
// import '../widget/ComfortLevel.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final globalcontroller = Get.put(GlobalController(), permanent: true);

//   // a function to update the state of the home screen widget
//   void updateState(bool isDarkMode, bool isFahrenheit) {
//     setState(() {
//       // update the state variables of the home screen widget
//       // use globalcontroller to store and access the values
//       globalcontroller.isDarkMode.value = isDarkMode;
//       globalcontroller.isFahrenheit.value = isFahrenheit;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // define the light theme
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.blue, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
//       ),
//       // define the dark theme
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: Colors.grey, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey.shade300),
//       ),
//       // use the themeMode property to switch between themes
//       themeMode: globalcontroller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
//       home: Consumer<CityProvider>(
//         builder: (context, value, child) {
//           return Scaffold(
//              appBar: AppBar(
//                 backgroundColor: CustomColors.firstGradientColor,
//                 title: const Text(
//                   'My Weather',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 // title: const Text('My Weather'),
//                 actions: (value.hasDataLoaded == true)
//                     ? [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const CityManagerPage()));
//                           },
//                           icon: const Icon(
//                             Icons.menu,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                              Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const WeatherSettingsPage(updateState: updateState(isDarkMode, isFahrenheit),)));
//                           },
//                           icon: const Icon(
//                             Icons.settings,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ]
//                     : [
//                         // Show nothing when weather data hasn't loaded
//                       ],
//               ),
//             //appBar: AppBar(title: const Text('My Weather')),
//             body: Obx(() => globalcontroller.checkStatus().isTrue
//                 ? Center(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset('assets/icons/clouds.png'),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           const CircularProgressIndicator(),
//                         ]),
//                   )
//                 : ListView(
//                     scrollDirection: Axis.vertical,
//                     children: [
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const HeaderSc(),
//                       CurrentWeatherWidget(
//                           globalcontroller.getWeatherData().weatherDataCurrent()),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       HourlyDataWidget(
//                         weatherDataHourly:
//                             globalcontroller.getWeatherData().weatherDataHourly(),
//                       ),
//                       SunInfo(
//                           weatherDataCurrent: globalcontroller
//                               .getWeatherData()
//                               .weatherDataCurrent()),
//                       DailyForecast(
//                         weatherDataDaily:
//                             globalcontroller.getWeatherData().weatherDataDaily(),
//                       ),
//                       const Divider(),
//                       ComfortLevel(
//                         weatherDataCurrent:
//                             globalcontroller.getWeatherData().weatherDataCurrent(),
//                       ),
//                       // a button to navigate to the weather setting page
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return WeatherSettingsPage(
//                                   // pass the updateState function as an argument
//                                   updateState: updateState,
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                         child: const Text('Go to Weather Settings'),
//                       ),
//                     ],
//                   )),
//                );
//         }
//       ),
// );
// }
// }















