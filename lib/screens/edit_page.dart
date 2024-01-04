import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/models/current_weather_data.dart';
import 'package:weatherapp_starter_project/widget/current_weather.dart';
import '../util/custom_colors.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // Define the state variables for storing the list of cities and the list of selected cities
  List<String> cities =
      []; // This should be updated with cities from CityManagerPage
  List<String> selectedCities = [];

  GlobalController globalController = GlobalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Cities'),
        // Add a back button to the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous page
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              // Get the city name from the list
              String city = cities[index];
              // Get the current weather data for the city
              WeatherDataCurrent weatherData =
                  globalController.getWeatherData(city).weatherDataCurrent();
              // Create the list tile widget with the city name and the weather widget
              return ListTile(
                title: Text(city),
                subtitle: CurrentWeatherWidget(weatherData),
                // Enable the long press action on the list tile
                onLongPress: () {
                  // Toggle the selection state of the city
                  setState(() {
                    // Check if the city is already in the selected list
                    if (selectedCities.contains(city)) {
                      // Remove the city from the selected list
                      selectedCities.remove(city);
                    } else {
                      // Add the city to the selected list
                      selectedCities.add(city);
                    }
                  });
                },
                // Display the prefix icon and the suffix icon on the list tile
                selected: selectedCities.contains(
                    city), // Check if the city is in the selected list
                leading: selectedCities
                        .contains(city) // If it is, display the menu icon
                    ? const Icon(
                        Icons.menu,
                        color: Colors.blue,
                      )
                    : null, // If it is not, display nothing
                trailing: selectedCities
                        .contains(city) // If it is, display the check box icon
                    ? const Icon(
                        Icons.check_box,
                        color: Colors.blue,
                      )
                    : null, // If it is not, display nothing
              );
            },
          ),
          // Display the number of items selected at the top of the page
          Visibility(
            visible: selectedCities
                .isNotEmpty, // Show the text widget if the selected list is not empty
            child: Text(
              "${selectedCities.length} Item(s) Selected", // Display the number of items selected
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      // // Display the number of items selected at the top of the page
      // Visibility(
      //   visible: selectedCities.isNotEmpty, // Show the text widget if the selected list is not empty
      //   child: Text(
      //     "${selectedCities.length} Item(s) Selected", // Display the number of items selected
      //     style: const TextStyle(
      //       color: Colors.black,
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Display the remove option at the bottom of the page
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          // Delete the selected cities from the list
          setState(() {
            // Remove the cities that are in the selected list
            cities.removeWhere((city) => selectedCities.contains(city));
            // Clear the selected list
            selectedCities.clear();
          });
          // Optionally, show a snackbar or a dialog to confirm the deletion

// Show the dialog using the showDialog method
          showDialog(
            context: context,
            builder: (context) {
              // Return a dialog widget
              return AlertDialog(
                // Set the title of the dialog
                title: const Text('Delete cities'),
                // Set the content of the dialog
                content: const Text(
                    'Are you sure you want to delete the selected cities?'),
                // Set the actions of the dialog
                actions: [
                  // Create a text button for canceling the deletion
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                  ),
                  // Create a text button for confirming the deletion
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      // Some code to delete the selected cities
                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
