import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_place/google_place.dart';
import 'package:google_place_plus/google_place_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp_starter_project/api/api_key.dart';
import 'package:weatherapp_starter_project/api/fetch_data.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/models/weather_data.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';

import 'package:flutter/material.dart';

class CityManagerPage extends StatefulWidget {
  const CityManagerPage({super.key});

  @override
  _CityManagerPageState createState() => _CityManagerPageState();
}

class _CityManagerPageState extends State<CityManagerPage> {
  List<String> searchedCities = [];

  final TextEditingController _cityController = TextEditingController();

  void changeCity(String newCity) async {
    // Your existing changeCity logic here
    if (!searchedCities.contains(newCity)) {
      setState(() {
        searchedCities.add(newCity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter City',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    changeCity(_cityController.text);
                  },
                ),
              ),
              onSubmitted: (newCity) {
                changeCity(newCity);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedCities.length,
              itemBuilder: (context, index) {
                return AnimatedCardTile(cityName: searchedCities[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedCardTile extends StatelessWidget {
  final String cityName;

  const AnimatedCardTile({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: Scaffold.of(context),
        )..forward(),
        curve: Curves.easeInOut,
      )),
      child: Card(
        child: ListTile(
          title: Text(cityName),
          // Add other details or actions as needed
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CityManagerPage(),
  ));
}

// class WeatherCityManagerPage extends StatefulWidget {
//   const WeatherCityManagerPage({super.key});

//   @override
//   _WeatherCityManagerPageState createState() => _WeatherCityManagerPageState();
// }

// class _WeatherCityManagerPageState extends State<WeatherCityManagerPage> {
//   final globalcontroller = Get.put(GlobalController(), permanent: true);
//   TextEditingController address = TextEditingController();
//   List<String> cityManager = [];

//   void addToCityManager(String cityName) {
//     setState(() {
//       cityManager.add(cityName);
//     });
//   }

//   Future<void> fetchWeatherForCity(
//       String cityName, TemperatureUnit temperatureUnit) async {
//     fetchData dataFetcher = fetchData();
//     try {
//       WeatherData cityWeatherData =
//           await dataFetcher.getDataForCity(cityName, temperatureUnit);
//       globalcontroller.checkStatus(cityWeatherData);
//     } catch (e) {
//       print('Error fetching weather data for $cityName: $e');
//       // Handle the error if fetching data fails
//     }
//   }

//   void searchLocation(String text) async {
//     if (text.isNotEmpty) {
//       var googlePlace = GooglePlace(
//           "<AIzaSyA28M-Ufy9RSZB1ShWi527M02VUThRx1sU>"); // Replace with your API key
//       var result = await googlePlace.search.getTextSearch(text, type: 'place');

//       List<String> searchResults = [];

//       if (result != null && result.results != null) {
//         searchResults =
//             result.results!.map((place) => place.formattedAddress!).toList();
//       }

//       setState(() {
//         cityManager = searchResults;
//       });
//     } else {
//       setState(() {
//         cityManager.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Weather City Manager'),
//       ),
//       body: Column(
//         children: [
//           TextFormField(
//             controller: address,
//             onChanged: (text) => searchLocation(text),
//             decoration: InputDecoration(
//               hintText: 'Search city...',
//               hintStyle: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white.withOpacity(0.7),
//                 fontWeight: FontWeight.w600,
//               ),
//               prefixIcon: Icon(
//                 Icons.search_rounded,
//                 size: 25,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//               border: InputBorder.none,

//               // Your input decoration
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: cityManager.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(cityManager[index]),
//                   onTap: () {
//                     String selectedCity = cityManager[index];
//                     fetchWeatherForCity(selectedCity,
//                         AppStateContainer.of(context).temperatureUnit);
//                   },
//                   // onTap: () {
//                   //   String selectedCity = cityManager[index];
//                   //   fetchWeatherForCity(selectedCity);
//                   // },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// commented early hours of the 12th january 2024
// class WeatherData {
//   String cityName;
//   double temperature;

//   WeatherData({required this.cityName, required this.temperature});

//   // Example method to create WeatherData from JSON
//   factory WeatherData.fromJson(Map<String, dynamic> json) {
//     return WeatherData(
//       cityName: json['name'] ?? 'Unknown City',
//       temperature: (json['main']['temp'] as double?) ?? 0.0,
//     );
//   }
// }

// // class GlobalController extends GetxController {
// //   var weatherData = WeatherData(cityName: '', temperature: 0.0).obs;

// //   void checkStatus(WeatherData data) {
// //     weatherData.value = data;
// //     update();
// //   }
// // }

// class FetchData {
//   Future<WeatherData> getData(String cityName) async {
//     String apiKey = api_key;
//     String url =
//         "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";

//     var response = await http.get(Uri.parse(url));
//     var json = jsonDecode(response.body);

//     return WeatherData.fromJson(json);
//   }
// }

// class WeatherCityManagerPage extends StatefulWidget {
//   const WeatherCityManagerPage({super.key});

//   @override
//   _WeatherCityManagerPageState createState() => _WeatherCityManagerPageState();
// }

// class _WeatherCityManagerPageState extends State<WeatherCityManagerPage> {
//   final globalController = Get.put(GlobalController(), permanent: true);
//   TextEditingController address = TextEditingController();
//   List<String> cityManager = [];

//   Future<void> fetchWeatherForCity(String cityName) async {
//     FetchData dataFetcher = FetchData();
//     try {
//       WeatherData cityWeatherData = await dataFetcher.getData(cityName);
//       globalController.checkStatus(cityWeatherData);
//       // globalController.checkStatus();
//     } catch (e) {
//       print('Error fetching weather data for $cityName: $e');
//     }
//   }

//   void searchLocation(String text) async {
//     if (text.isNotEmpty) {
//       var googlePlace = GooglePlace("AIzaSyA28M-Ufy9RSZB1ShWi527M02VUThRx1sU");
//       var result = await googlePlace.search.getTextSearch(text, type: 'place');

//       List<String> searchResults = [];

//       if (result != null && result.results != null) {
//         searchResults =
//             result.results!.map((place) => place.formattedAddress!).toList();
//       }

//       setState(() {
//         cityManager = searchResults;
//       });
//     } else {
//       setState(() {
//         cityManager.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Weather City Manager'),
//       ),
//       body: Column(
//         children: [
//           TextFormField(
//             controller: address,
//             onChanged: (text) => searchLocation(text),
//             decoration: const InputDecoration(
//               hintText: 'Search city...',
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: cityManager.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(cityManager[index]),
//                   onTap: () {
//                     String selectedCity = cityManager[index];
//                     fetchWeatherForCity(selectedCity);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:weatherapp_starter_project/api/fetch_data.dart';
// import 'package:weatherapp_starter_project/controller/global_controller.dart';
// import 'package:weatherapp_starter_project/models/current_weather_data.dart';
// import 'package:weatherapp_starter_project/models/weather_data.dart';
// import 'package:weatherapp_starter_project/widget/current_weather.dart';
// import '../util/custom_colors.dart';
// import 'add_city_page.dart';



// //import 'your_data_fetching_file.dart'; // Import your fetchData class here

// class CityManagerPage extends StatefulWidget {
//   @override
//   _CityManagerPageState createState() => _CityManagerPageState();
// }

// class _CityManagerPageState extends State<CityManagerPage> {

// final globalcontroller = Get.put(GlobalController(), permanent: true);
//   TextEditingController address = TextEditingController();
//   List<String> cityManager = [];

//   void addToCityManager(String cityName) {
//     setState(() {
//       cityManager.add(cityName);
//     });
//   }

//   Future<void> fetchWeatherForCity(String cityName) async {
//     fetchData dataFetcher = fetchData();
//     try {
//       WeatherData cityWeatherData = await dataFetcher.getDataForCity(cityName);
//       globalcontroller.checkStatus(cityWeatherData);
//     } catch (e) {
//       print('Error fetching weather data for $cityName: $e');
//       // Handle the error if fetching data fails
//     }
//   }

//   void searchLocation(String text) async {
//     if (text.isNotEmpty) {
//       var googlePlace = GooglePlace("<AIzaSyA28M-Ufy9RSZB1ShWi527M02VUThRx1sU>"); // Replace with your API key
//       var result = await googlePlace.search.getTextSearch(text, type: 'place');

//       List<String> searchResults = [];

//       if (result != null && result.results != null) {
//         searchResults = result.results!.map((place) => place.formattedAddress!).toList();
//       }

//       setState(() {
//         cityManager = searchResults;
//       });
//     } else {
//       setState(() {
//         cityManager.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather City Manager'),
//       ),
//       body: Column(
//         children: [
//           TextFormField(
//             controller: address,
//             onChanged: (text) => searchLocation(text),
//             decoration: InputDecoration(
//               hintText: 'Search city...',
// hintStyle: TextStyle( fontSize: 18,
// color: Colors.white.withOpacity(0.7),
// fontWeight: FontWeight.w600,
// ), prefixIcon: Icon(Icons.search_rounded, size  : 25,
// color: Colors.white.withOpacity(0.7),
// ),
// border: InputBorder.none,
 
//               // Your input decoration
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: cityManager.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(cityManager[index]),
//                   onTap: () {
//                     String selectedCity = cityManager[index];
//                     fetchWeatherForCity(selectedCity);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//      ),
// );
// }
// }

// commented out on the 11th of January 2024
// class CityManagerPage extends StatefulWidget {
//   const CityManagerPage({super.key});

//   @override
//   _CityManagerPageState createState() => _CityManagerPageState();
// }

// class _CityManagerPageState extends State<CityManagerPage> {
//   // Define the state variable for storing the list of cities
//   List<String> cities =
//       []; // This should be updated with cities from ADD CITY-PAGE/SCREEN
//   GlobalController globalController = GlobalController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // // Add a background image to the scaffold

//       // decoration: BoxDecoration(
//       //   image: DecorationImage(
//       //     image: Image.asset('assets/background.jpg'),
//       //     fit: BoxFit.cover,
//       //   ),
//       // ),
//       // Add a floating action button to the scaffold
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () async {
//           // Navigate to the ADD CITY-PAGE/SCREEN and get the city name
//           String city = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const AddCityPage(),
//             ),
//           );
//           // Add the city name to the list
//           setState(() {
//             cities.add(city);
//           });
//         },
//       ),
//       appBar: AppBar(
//         backgroundColor: CustomColors.firstGradientColor,
//         title: const Text(
//           'City Management',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Container(
//         // Add a background image to the scaffold

//         decoration: const BoxDecoration(),
//         child: ListView.builder(
//             shrinkWrap: true,
//             // Add some padding to the list view
//             padding: const EdgeInsets.all(16),
//             itemCount: cities.length,
//             itemBuilder: (context, index) {
//               // Get the city name from the list
//               String city = cities[index];
//               // Get the current weather data for the city
//               WeatherDataCurrent weatherData =
//                   globalController.getWeatherData(city).weatherDataCurrent();
//               // Create the list tile widget with the city name and the weather widget
//               return GestureDetector(
//                 onLongPress: () {
//                   // Delete the city from the list
//                   setState(() {
//                     String deletedCity = cities.removeAt(index);
//                     // Show a snackbar with an undo option
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Deleted $deletedCity'),
//                         action: SnackBarAction(
//                           label: 'Undo',
//                           onPressed: () {
//                             // Restore the city to the list
//                             setState(() {
//                               cities.insert(index, deletedCity);
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   });
//                 },
//                 child: Container(
//                   // Add a gradient effect to the list tile
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Colors.transparent, Colors.black],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                     // Add some rounded corners to the list tile
//                     borderRadius: BorderRadius.circular(16),
//                     // Add some shadow to the list tile
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         offset: const Offset(0, 4),
//                         blurRadius: 8,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: ListTile(
//                     // Change the text color and style of the city name
//                     title: Text(
//                       city,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     // Change the text color and style of the weather data
//                     subtitle: Text(
//                       weatherData.current.weather.toString(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weatherapp_starter_project/components/city_manager_bottom_nav.dart';
// import 'package:weatherapp_starter_project/components/city_manager_tiles.dart';
// import 'package:weatherapp_starter_project/data/city_provider.dart';


// // A widget that displays the City Manager Page/Screen
// class CityManagerPage extends StatefulWidget {
//   @override
//   _CityManagerPageState createState() => _CityManagerPageState();
// }

// class _CityManagerPageState extends State<CityManagerPage> {
//   // A set to store the selected items
//   Set<City> selectedItems = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('City Management'),
//       ),
//       body: Consumer<CityProvider>(
//         builder: (context, provider, child) {
//           return ListView.builder(
//             itemCount: provider.cities.length,
//             itemBuilder: (context, index) {
//               // Get the city from the list
//               City city = provider.cities[index];
//               return ListTile(
//                 title: Text(city.name),
//                 subtitle: Text('${city.temperature}° ${city.condition}'),
//                 // Check if the item is selected or not and change the color accordingly
//                 tileColor: selectedItems.contains(city)
//                     ? Colors.blue[100]
//                     : Colors.white,
//                 // Display a check icon if the item is selected
//                 trailing: selectedItems.contains(city)
//                     ? Icon(Icons.check, color: Colors.blue)
//                     : null,
//                 onLongPress: () {
//                   // Handle the long press gesture and select or deselect the item
//                   setState(() {
//                     if (selectedItems.contains(city)) {
//                       selectedItems.remove(city);
//                     } else {
//                       selectedItems.add(city);
//                     }
//                   });
//                 },
//               );
//             },
//           );
//         },
//       ),
//       // Display the bottom app bar with the options
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // Display the number of selected items
//             Text('${selectedItems.length} item(s) selected'),
//             // Display a remove button that deletes the selected items from the list
//             ElevatedButton(
//               onPressed: () {
//                 // Remove the selected items from the list using the Provider
//                 Provider.of<CityProvider>(context, listen: false)
//                     .removeCities(selectedItems);

//                 // Clear the set of selected items and update the UI
//                 setState(() {
//                   selectedItems.clear();
//                 });
//               },
//               child: Text('Remove'),
//             ),
//           ],
//         ),
//       ),
//       // Display a floating action button that navigates to the Add City Page/Screen
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddCityPage()),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// // A widget that displays the Add City Page/Screen
// // The code for this widget is the same as the previous example
// class AddCityPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add City'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // A text field to enter the city name
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Enter city name',
//               ),
//               onSubmitted: (value) {
//                 // Fetch the weather data for the city using the fetchData method
//                 // For simplicity, we use dummy data here
//                 City city = City(value, 25, 'Sunny');

//                 // Add the city to the list using the Provider
//                 Provider.of<CityProvider>(context, listen: false).addCity(city);

//                 // Navigate to the City Manager Page/Screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CityManagerPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class CityManager extends StatelessWidget {
//   const CityManager({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Consumer<CityProvider>(builder: (context, value, child) {
//       return Scaffold(
//         appBar: AppBar(
//           title: (value.edit == false)
//               ? const Text(
//                   'CITY MANAGER',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 )
//               : const Text(
//                   'EDIT CITY',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//         ),
//         bottomNavigationBar: const CityManagerBottomNavBar(),
//         body: ListView(
//           children: [
//             ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: value.cities.length,
//                 itemBuilder: (context, index) {
//                   return CityMangerTiles(
//                     cityName: value.cities[index][0],
//                     weatherDegree: value.cities[index][1],
//                     index: index,
//                   );
//                 }),
//           ],
//         ),
//       );
//     });
//   }
// }
