import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/api/fetch_data.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapp_starter_project/provider/city_provider.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';

class HeaderSc extends StatefulWidget {
  const HeaderSc({super.key});

  @override
  State<HeaderSc> createState() => _HeaderScState();
}

class _HeaderScState extends State<HeaderSc> {
  String city = "";
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  String date = DateFormat("yMMMd").format(DateTime.now());

  bool showSearchBar = false;
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    getCity(globalController.getlat().value, globalController.getlng().value);
    super.initState();
  }

  getCity(lat, lng) async {
    final url = Uri.parse(
        'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lng&localityLanguage=en');
    final response = await http.get(url);
    final data = jsonDecode(response.body);

    setState(() {
      city = '${data["locality"].toString()}, ${data["city"].toString()}';
      Provider.of<CityProvider>(context, listen: false).changeDataStatus();
    });
  }

  void toggleSearchBar() {
    setState(() {
      showSearchBar = !showSearchBar;
    });
  }

  void changeCity(String newCity) async {
    double lat, lng;

    var locations = await locationFromAddress(newCity);

    if (locations.isNotEmpty) {
      lat = locations[0].latitude;
      lng = locations[0].longitude;

      setState(() {
        city = newCity;
      });

      fetchData().getData(lat, lng, TemperatureUnit.celsius);
    } else {
      print("Invalid city name");
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    TemperatureUnit temperatureUnit =
        AppStateContainer.of(context).temperatureUnit;

    return Column(
      children: [
        // Include the AnimatedSearchBar widget at the top
        // AnimatedSearchBar(
        //   showSearchBar: showSearchBar,
        //   toggleSearchBar: toggleSearchBar,
        //   changeCity: changeCity,
        //   cityController: _cityController,
        // ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: city.length > 2
              ? Text(
                  city,
                  style: TextStyle(
                      height: 2,
                      fontSize: 30,
                      // color: appTheme.textTheme.displayLarge!.color,
                      color: appTheme.colorScheme.secondary),
                )
              : Text(
                  'Getting the name...',
                  style: TextStyle(
                      height: 2,
                      fontSize: 20,
                      // color: appTheme.textTheme.displayLarge!.color,
                      color: appTheme.colorScheme.secondary),
                ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(
                height: 1.5,
                fontSize: 14,
                // color: appTheme.textTheme.displayMedium!.color,
                color: appTheme.colorScheme.secondary),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     // Add functionality for the button
        //     print("Button pressed!");
        //   },
        //   child: Text(
        //     'Your Button',
        //     style: TextStyle(color: appTheme.colorScheme.secondary),
        //   ),
        // ),
        // const SizedBox(height: 20), // Add spacing if needed

        // Example: Display a list of items
        // Expanded(
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: 5, // Replace with your actual item count
        //     itemBuilder: (context, index) {
        //       return ListTile(
        //         title: Text('Item $index'),
        //         // Add other details or actions as needed
        //       );
        //     },
        //   ),
        // ),
        // Add more UI components as needed
      ],
    );
  }
}

class AnimatedSearchBar extends StatefulWidget {
  final bool showSearchBar;
  final Function toggleSearchBar;
  final Function changeCity;
  final TextEditingController cityController;

  const AnimatedSearchBar({
    super.key,
    required this.showSearchBar,
    required this.toggleSearchBar,
    required this.changeCity,
    required this.cityController,
  });

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: widget.showSearchBar ? kToolbarHeight + 10 : 0,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: Scaffold.of(context),
            // vsync: this,
          )..forward(),
          curve: Curves.easeInOut,
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.cityController,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: appTheme.colorScheme.secondary),
              hintText: 'Enter City',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  widget.changeCity(widget.cityController.text);
                  widget.toggleSearchBar();
                },
              ),
            ),
            onSubmitted: (newCity) {
              widget.changeCity(newCity);
              widget.toggleSearchBar();
            },
          ),
        ),
      ),
    );
  }
}

// class AnimatedSearchBar extends StatelessWidget {
//   final bool showSearchBar;
//   final VoidCallback toggleSearchBar;
//   final Function(String) changeCity;
//   final TextEditingController cityController;

//   AnimatedSearchBar({
//     required this.showSearchBar,
//     required this.toggleSearchBar,
//     required this.changeCity,
//     required this.cityController,
// });

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:provider/provider.dart';
// import 'package:weatherapp_starter_project/controller/global_controller.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:weatherapp_starter_project/data/city_provider.dart';
// import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
// import 'package:weatherapp_starter_project/setting_stuf/converter.dart';

// class HeaderSc extends StatefulWidget {
//   const HeaderSc({super.key});

//   @override
//   State<HeaderSc> createState() => _HeaderScState();
// }

// class _HeaderScState extends State<HeaderSc> {
//   String city = "";
//   final GlobalController globalController =
//       Get.put(GlobalController(), permanent: true);
//   String date = DateFormat("yMMMd").format(DateTime.now());

//   @override
//   void initState() {
//     getCity(globalController.getlat().value, globalController.getlng().value);
//     super.initState();
//   }

//   getCity(lat, lng) async {
//     final url = Uri.parse(
//         'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lng&localityLanguage=en');
//     final response = await http.get(url);
//     final data = jsonDecode(response.body);

//     setState(() {
//       city = '${data["locality"].toString()}, ${data["city"].toString()}';
//       Provider.of<CityProvider>(context, listen: false).changeDataStatus();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CityProvider>(builder: (context, value, child) {
//       ThemeData appTheme = AppStateContainer.of(context).theme;
//       TemperatureUnit temperatureUnit =
//           AppStateContainer.of(context).temperatureUnit;

//       // Use appTheme and temperatureUnit in your widget

//       return Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20),
//             alignment: Alignment.topLeft,
//             child: city.length > 2
//                 ? Text(
//                     city,
//                     style: TextStyle(
//                       height: 2,
//                       fontSize: 30,
//                       color: appTheme.textTheme.displayLarge!.color,
//                     ),
//                   )
//                 : Text(
//                     'Getting the name...',
//                     style: TextStyle(
//                       height: 2,
//                       fontSize: 20,
//                       color: appTheme.textTheme.displayLarge!.color,
//                     ),
//                   ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//             alignment: Alignment.topLeft,
//             child: Text(
//               date,
//               style: TextStyle(
//                 height: 1.5,
//                 fontSize: 14,
//                 color: appTheme.textTheme.displayMedium!.color,
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

// class HeaderSc extends StatefulWidget {
//   const HeaderSc({super.key});

//   @override
//   State<HeaderSc> createState() => _HeaderScState();
// }

// class _HeaderScState extends State<HeaderSc> {
//   String city = "";
//   final GlobalController globalController =
//       Get.put(GlobalController(), permanent: true);
//   String date = DateFormat("yMMMd").format(DateTime.now());
//   @override
//   void initState() {
//     getCity(globalController.getlat().value, globalController.getlng().value);
//     // Provider.of<Data>(context, listen: false).changeDataStatus();
//     super.initState();
//   }

//   getCity(lat, lng) async {
//     // List<Placemark> placemark = await placemarkFromCoordinates(lat, lng);
//     // print(placemark[0]);
//     final url = Uri.parse(
//         'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lng&localityLanguage=en');
//     final response = await http.get(url);
//     final data = jsonDecode(response.body);

//     setState(() {
//       // city = placemark[0].subAdministrativeArea.toString();
//       city = '${data["locality"].toString()}, ${data["city"].toString()}';
//       Provider.of<CityProvider>(context, listen: false).changeDataStatus();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CityProvider>(builder: (context, value, child) {
//       // value.changeDataStatus();

//       print(value.hasDataLoaded);

//       return Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20),
//             alignment: Alignment.topLeft,
//             child: city.length > 2
//                 ? Text(
//                     city,
//                     style: const TextStyle(height: 2, fontSize: 30),
//                   )
//                 : const Text(
//                     'Getting the name...',
//                     style: TextStyle(height: 2, fontSize: 20),
//                   ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//             alignment: Alignment.topLeft,
//             child: Text(
//               date,
//               style: const TextStyle(
//                   height: 1.5, fontSize: 14, color: Colors.grey),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
