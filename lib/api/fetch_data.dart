import 'dart:convert';

import 'package:weatherapp_starter_project/models/weather_data.dart';
import 'package:weatherapp_starter_project/models/current_weather_data.dart';
import 'package:weatherapp_starter_project/models/hourly_weather_data.dart';
import 'package:weatherapp_starter_project/models/daily_weather_data.dart';
import 'package:http/http.dart' as http;
import './api_key.dart';
import 'package:location_geocoder/location_geocoder.dart';

class fetchData {
  WeatherData? weatherData;
  String? city;

  Future<WeatherData> getData(lat, lng) async {
    var response = await http.get(Uri.parse(apiURL(lat, lng)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    // get the city name from the coordinates
    var coordinates = Coordinates(lat, lng);

    // var addresses = await geocoder.local.findAddressesFromCoordinates(coordinates);
    // city = addresses.first.locality; // assign the city name to the variable

    return weatherData!;
  }

  Future<WeatherData> getDataForCity(String cityName) async {
    var response = await http.get(Uri.parse(apiURLForCity(cityName)));
    var jsonString = jsonDecode(response.body);
    // Assuming your API returns weather data for the provided city name
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );
    return weatherData!;
  }

  String apiURLForCity(String cityName) {
    // Create API URL based on city name
    String url =
        "https://api.openweathermap.org/data/3.0/onecall?q=$cityName&appid=$api_key&exclude=minutely&units=metric";
    return url;
  }
}

String apiURL(lat, lng) {
  String url;
  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lng&appid=$api_key&exclude=minutely&units=metric";
  return url;
}


// import 'dart:convert';
// import 'package:weatherapp_starter_project/models/weather_data.dart';
// import 'package:weatherapp_starter_project/models/current_weather_data.dart';
// import 'package:weatherapp_starter_project/models/hourly_weather_data.dart';
// import 'package:weatherapp_starter_project/models/daily_weather_data.dart';
// import 'package:http/http.dart' as http;
// import './api_key.dart';

// class fetchData {
//   WeatherData? weatherData;

//   Future<WeatherData> getData(lat, lng) async {
//     var response = await http.get(Uri.parse(apiURL(lat, lng)));
//     var jsonString = jsonDecode(response.body);
//     weatherData = WeatherData(
//         WeatherDataCurrent.fromJson(jsonString),
//         WeatherDataHourly.fromJson(jsonString),
//         WeatherDataDaily.fromJson(jsonString));
//     return weatherData!;
//   }
// }

// String apiURL(lat, lng) {
//   String url;
//   url =
//       "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lng&appid=$api_key&exclude=minutely&units=metric";
//   return url;
// }