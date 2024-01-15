import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapp_starter_project/data/city_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(builder: (context, value, child) {
      ThemeData appTheme = AppStateContainer.of(context).theme;
      TemperatureUnit temperatureUnit =
          AppStateContainer.of(context).temperatureUnit;

      // Use appTheme and temperatureUnit in your widget

      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.topLeft,
            child: city.length > 2
                ? Text(
                    city,
                    style: TextStyle(
                      height: 2,
                      fontSize: 30,
                      color: appTheme.textTheme.displayLarge!.color,
                    ),
                  )
                : Text(
                    'Getting the name...',
                    style: TextStyle(
                      height: 2,
                      fontSize: 20,
                      color: appTheme.textTheme.displayLarge!.color,
                    ),
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
                color: appTheme.textTheme.displayMedium!.color,
              ),
            ),
          ),
        ],
      );
    });
  }
}


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
