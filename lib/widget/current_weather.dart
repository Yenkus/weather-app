import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/models/current_weather_data.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';
import '../util/custom_colors.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherWidget(this.weatherDataCurrent, {super.key});

  String getTemperature(BuildContext context) {
    switch (AppStateContainer.of(context).temperatureUnit) {
      case TemperatureUnit.celsius:
        return "${weatherDataCurrent.current.temp}°C";
      case TemperatureUnit.fahrenheit:
        double tempF = (weatherDataCurrent.current.temp! * 9 / 5) + 32;
        return "${tempF.toStringAsFixed(2)}°F";
      case TemperatureUnit.kelvin:
        double tempK = weatherDataCurrent.current.temp! + 273.15;
        return "${tempK.toStringAsFixed(2)}K";
    }
  }

  Widget currentWeatherDataWidget(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(
          width: 1,
          height: 50,
          color: CustomColors.dividerLine,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: getTemperature(context),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 68,
                color: appTheme.colorScheme.secondary,
              ),
            ),
            TextSpan(
              text: "${weatherDataCurrent.current.weather![0].description}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ]),
        )
      ],
    );
  }

  Widget moreDetailsOnCurrentWeatherData(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/windspeed.png",
                  fit: BoxFit.contain),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child:
                  Image.asset("assets/icons/clouds.png", fit: BoxFit.contain),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child:
                  Image.asset("assets/icons/humidity.png", fit: BoxFit.contain),
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.windSpeed} km/h",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: appTheme.colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.clouds}%",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: appTheme.colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.humidity}%",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: appTheme.colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    return Column(
      children: [
        // current weather
        currentWeatherDataWidget(context),
        const SizedBox(
          height: 20,
        ),
        // More details
        moreDetailsOnCurrentWeatherData(context),
      ],
    );
  }
}


// class CurrentWeatherWidget extends StatelessWidget {
//   final WeatherDataCurrent weatherDataCurrent;
//   const CurrentWeatherWidget(this.weatherDataCurrent, {super.key});

//   Widget CurrentWeatherDataWidget() {
//     // @override
//     // Widget build(BuildContext context) {
//     //   ThemeData appTheme = AppStateContainer.of(context).theme;
//     //   TemperatureUnit unit = AppStateContainer.of(context).temperatureUnit;
//     //   Temperature temperature = Temperature(_kelvin);
//     //   // int currentTemp = this.weatherDataCurrent.current.temp?.as(unit)?.round()??0;
//     //   //  int currentTemp = this.weatherDataCurrent.current.temp.as(unit).round();
//     //   int currentTemp =
//     //       weatherDataCurrent.current.temp.temperature().as(unit).round();
//     // }

// // In line 26:
// // Text (" ${currentTemp}°",

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Image.asset(
//           "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
//           height: 80,
//           width: 80,
//         ),
//         Container(
//           width: 1,
//           height: 50,
//           color: CustomColors.dividerLine,
//         ),
//         RichText(
//           text: TextSpan(children: [
//             TextSpan(
//                 text: "${weatherDataCurrent.current.temp}°",
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 68,
//                     color: CustomColors.textColorBlack)),
//             TextSpan(
//                 text: "${weatherDataCurrent.current.weather![0].description}",
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                     color: Colors.grey)),
//           ]),
//         )
//       ],
//     );
//   }

//   Widget MoreDetailsOnCurrentWeatherData() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                   color: CustomColors.cardColor,
//                   borderRadius: BorderRadius.circular(15)),
//               child: Image.asset("assets/icons/windspeed.png",
//                   fit: BoxFit.contain),
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                   color: CustomColors.cardColor,
//                   borderRadius: BorderRadius.circular(15)),
//               child:
//                   Image.asset("assets/icons/clouds.png", fit: BoxFit.contain),
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                   color: CustomColors.cardColor,
//                   borderRadius: BorderRadius.circular(15)),
//               child:
//                   Image.asset("assets/icons/humidity.png", fit: BoxFit.contain),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 7,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SizedBox(
//               height: 20,
//               width: 60,
//               child: Text(
//                 "${weatherDataCurrent.current.windSpeed} km/h",
//                 style:
//                     const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//               width: 60,
//               child: Text(
//                 "${weatherDataCurrent.current.clouds}%",
//                 style:
//                     const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//               width: 60,
//               child: Text(
//                 "${weatherDataCurrent.current.humidity}%",
//                 style:
//                     const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //current weather
//         CurrentWeatherDataWidget(),
//         const SizedBox(
//           height: 20,
//         ),
//         //More details
//         MoreDetailsOnCurrentWeatherData(),
//       ],
//     );
//   }
// }
