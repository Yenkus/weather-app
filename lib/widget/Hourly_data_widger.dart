import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';
import '../models/hourly_weather_data.dart';
import '../util/custom_colors.dart';
import 'package:intl/intl.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly? weatherDataHourly;
  HourlyDataWidget({super.key, this.weatherDataHourly});

  RxInt cardIndex = GlobalController().getIndex();
  String getFormattedTemperature(
      {required int temperature, required BuildContext context}) {
    // String getFormattedTemperature(int temperature) {
    TemperatureUnit unit = AppStateContainer.of(context).temperatureUnit;
    switch (unit) {
      case TemperatureUnit.celsius:
        return '$temperature°C';
      case TemperatureUnit.fahrenheit:
        int fahrenheitTemperature = ((temperature * 9 / 5) + 32).round();
        return '$fahrenheitTemperature°F';
      case TemperatureUnit.kelvin:
        double kelvinTemperature = temperature + 273.15;
        return '${kelvinTemperature.toStringAsFixed(2)}K';
    }
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly!.hourly.length > 12
            ? 12
            : weatherDataHourly!.hourly.length,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 80,
                  margin: const EdgeInsets.only(left: 15, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0.5, 0),
                          blurRadius: 30,
                          spreadRadius: 1,
                          color: CustomColors.dividerLine.withAlpha(150),
                        ),
                      ],
                      gradient: cardIndex.value == index
                          ? const LinearGradient(colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor
                            ])
                          : null),
                  child: HourlyDetails(
                    index: index,
                    cardindex: cardIndex.value,
                    temperature: weatherDataHourly!.hourly[index].temp!,
                    timeStamp: weatherDataHourly!.hourly[index].dt!,
                    icon: weatherDataHourly!.hourly[index].weather![0].icon!,
                  ),
                ),
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: const Text(
            'Today',
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final int temperature;
  final int timeStamp;
  final String icon;
  final int index;
  final int cardindex;
  const HourlyDetails(
      {super.key,
      required this.temperature,
      required this.icon,
      required this.timeStamp,
      required this.index,
      required this.cardindex});

  String getTime(int dt) {
    DateTime dd = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    String time = DateFormat('jm').format(dd);
    return time;
  }

  String getFormattedTemperature(
      {required BuildContext context, required int temperature}) {
//  String getFormattedTemperature(int temperature) {
    TemperatureUnit unit = AppStateContainer.of(context).temperatureUnit;
    return TemperatureFormatter.getFormattedTemperature(temperature, unit);
  }

  // String getFormattedTemperature(
  //     {required BuildContext context, required int temperature}) {
  //   // String getFormattedTemperature() {
  //   return AppStateContainer.of(context).getFormattedTemperature(
  //       temperature, AppStateContainer.of(context).temperatureUnit);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: index == cardindex
                ? const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)
                : null,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$icon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            getFormattedTemperature(context: context, temperature: temperature),
            style: index == cardindex
                ? const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)
                : null,
          ),
        ),
      ],
    );
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
