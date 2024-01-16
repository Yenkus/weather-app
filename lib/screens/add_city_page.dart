import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/provider/city_provider.dart';
import 'package:weatherapp_starter_project/util/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCityPage extends StatefulWidget {
  const AddCityPage({super.key});

  @override
  _AddCityPageState createState() => _AddCityPageState();
}

class _AddCityPageState extends State<AddCityPage> {
  // Define the text editing controller for the search text field
  TextEditingController textEditingController = TextEditingController();

  // Define the function for getting the suggestions for the city names
  Future<List<String>> getSuggestions(String input) async {
    // Make a GET request to the Google Places API with the input text and the API key
    http.Response response = await http.get(Uri.http(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=(cities)&key=135e94f00c4980f0ba4781037d969eaa'));
    // http.Response response = await http.get(
    //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=(cities)&key=135e94f00c4980f0ba4781037d969eaa');

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Parse the response body as a JSON map
      var results = jsonDecode(response.body);

      // Get the list of predictions from the JSON map
      List<dynamic> predictions = results['predictions'];

      // Map the predictions to a list of city names
      List<String> cityNames = predictions.map((prediction) {
        // Get the description and the terms from the prediction
        String description = prediction['description'];
        List<dynamic> terms = prediction['terms'];

        // Get the city name and the country name from the terms
        String cityName = terms[0]['value'];
        String countryName = terms.last['value'];

        // Return the city name and the country name as a string
        return '$cityName, $countryName';
      }).toList();

      // Return the list of city names
      return cityNames;
    } else {
      // Handle the error
      print('Error: ${response.statusCode}');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add City'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                // Add a text field with a hint text
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: 'search city names here',
                ),
              ),
              Autocomplete<String>(
                // Add an autocomplete widget with the suggestions
                optionsBuilder: (textEditingValue) {
                  // Get the suggestions for the input text
                  return getSuggestions(textEditingValue.text);
                },
                optionsViewBuilder: (context, onSelected, options) {
                  // Display the suggestions in a list view
                  return ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      // Get the city name from the options
                      String cityName = options.elementAt(index);

                      // Create a list tile widget with the city name
                      return ListTile(
                        title: Text(cityName),
                        onTap: () {
                          // Add the city to the list of cities in the city manager page
                          // Check if the city is already in the list
                          if (value.cities.contains(cityName)) {
                            // Show a snackbar to inform the user that the city is already added
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('$cityName is already in the list'),
                              ),
                            );
                          } else {
                            // Pass the city name back to the previous page
                            Navigator.pop(context, cityName);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}


// class AddCityPage extends StatelessWidget {
//   const AddCityPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     TextEditingController? controller;
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text(
//         'ADD CITY',
//         style: TextStyle(fontWeight: FontWeight.bold),
//       )),
//       body: ListView(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(color: CustomColors.firstGradientColor)),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     // padding: EdgeInsets.only(right: size.width * 0.09),
//                     width: size.width * 0.62,
//                     child: TextField(
//                       controller: controller,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Search City',
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.search),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
