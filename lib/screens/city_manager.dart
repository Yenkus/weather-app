import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/models/current_weather_data.dart';
import 'package:weatherapp_starter_project/widget/current_weather.dart';
import '../util/custom_colors.dart';
import 'add_city_page.dart';

class CityManagerPage extends StatefulWidget {
  const CityManagerPage({super.key});

  @override
  _CityManagerPageState createState() => _CityManagerPageState();
}

class _CityManagerPageState extends State<CityManagerPage> {
  // Define the state variable for storing the list of cities
  List<String> cities =
      []; // This should be updated with cities from ADD CITY-PAGE/SCREEN
  GlobalController globalController = GlobalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // // Add a background image to the scaffold

      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: Image.asset('assets/background.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      // Add a floating action button to the scaffold
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Navigate to the ADD CITY-PAGE/SCREEN and get the city name
          String city = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCityPage(),
            ),
          );
          // Add the city name to the list
          setState(() {
            cities.add(city);
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: CustomColors.firstGradientColor,
        title: const Text(
          'City Management',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        // Add a background image to the scaffold

        decoration: const BoxDecoration(),
        child: ListView.builder(
            shrinkWrap: true,
            // Add some padding to the list view
            padding: const EdgeInsets.all(16),
            itemCount: cities.length,
            itemBuilder: (context, index) {
              // Get the city name from the list
              String city = cities[index];
              // Get the current weather data for the city
              WeatherDataCurrent weatherData =
                  globalController.getWeatherData(city).weatherDataCurrent();
              // Create the list tile widget with the city name and the weather widget
              return GestureDetector(
                onLongPress: () {
                  // Delete the city from the list
                  setState(() {
                    String deletedCity = cities.removeAt(index);
                    // Show a snackbar with an undo option
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Deleted $deletedCity'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Restore the city to the list
                            setState(() {
                              cities.insert(index, deletedCity);
                            });
                          },
                        ),
                      ),
                    );
                  });
                },
                child: Container(
                  // Add a gradient effect to the list tile
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.transparent, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    // Add some rounded corners to the list tile
                    borderRadius: BorderRadius.circular(16),
                    // Add some shadow to the list tile
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ListTile(
                    // Change the text color and style of the city name
                    title: Text(
                      city,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Change the text color and style of the weather data
                    subtitle: Text(
                      weatherData.current.weather.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}


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
