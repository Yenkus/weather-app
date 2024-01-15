import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/data/city_provider.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';
import '../models/hourly_weather_data.dart';
import '../util/custom_colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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



// class HourlyDataWidget extends StatelessWidget {
//   final WeatherDataHourly? weatherDataHourly;
//   HourlyDataWidget({super.key, this.weatherDataHourly});

//   RxInt cardIndex = GlobalController().getIndex();
//   Widget hourlyList() {
//     return Container(
//       height: 150,
//       padding: const EdgeInsets.only(top: 10, bottom: 10),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weatherDataHourly!.hourly.length > 12
//             ? 12
//             : weatherDataHourly!.hourly.length,
//         itemBuilder: (context, index) {
//           return Obx(() => GestureDetector(
//                 onTap: () {
//                   cardIndex.value = index;
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 150),
//                   width: 80,
//                   margin: const EdgeInsets.only(left: 15, right: 5),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           offset: const Offset(0.5, 0),
//                           blurRadius: 30,
//                           spreadRadius: 1,
//                           color: CustomColors.dividerLine.withAlpha(150),
//                         ),
//                       ],
//                       gradient: cardIndex.value == index
//                           ? const LinearGradient(colors: [
//                               CustomColors.firstGradientColor,
//                               CustomColors.secondGradientColor
//                             ])
//                           : null),
//                   child: HourlyDetails(
//                     index: index,
//                     cardindex: cardIndex.value,
//                     tmp: weatherDataHourly!.hourly[index].temp!,
//                     timeStamp: weatherDataHourly!.hourly[index].dt!,
//                     icon: weatherDataHourly!.hourly[index].weather![0].icon!,
//                   ),
//                 ),
//               ));
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           alignment: Alignment.topCenter,
//           child: const Text(
//             'Today',
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//         hourlyList(),
//       ],
//     );
//   }
// }

// class HourlyDetails extends StatelessWidget {
//   final int tmp;
//   final int timeStamp;
//   final String icon;
//   final int index;
//   final int cardindex;
//   const HourlyDetails(
//       {required this.tmp,
//       required this.icon,
//       required this.timeStamp,
//       required this.index,
//       required this.cardindex});

//   String getTime(int dt) {
//     DateTime dd = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
//     String time = DateFormat('jm').format(dd);
//     return time;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Container(
//           margin: const EdgeInsets.only(top: 10),
//           child: Text(
//             getTime(timeStamp),
//             style: index == cardindex
//                 ? const TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.white)
//                 : null,
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.all(5),
//           child: Image.asset(
//             "assets/weather/$icon.png",
//             height: 40,
//             width: 40,
//           ),
//         ),
//         Container(
//             margin: const EdgeInsets.only(bottom: 10),
//             child: Text(
//               '$tmp°',
//               style: index == cardindex
//                   ? const TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.white)
//                   : null,
//             )),
//       ],
//     );
//   }
// }
