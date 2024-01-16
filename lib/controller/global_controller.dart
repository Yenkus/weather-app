import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/provider/city_provider.dart';
import 'package:weatherapp_starter_project/setting_stuf/app_state_container.dart';
import 'package:weatherapp_starter_project/setting_stuf/converter.dart';

import '../api/fetch_data.dart';
import '../models/weather_data.dart';
import '../models/current_weather_data.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _lat = 0.0.obs;
  final RxDouble _lng = 0.0.obs;
  final RxInt cardIndex = 0.obs;
  final weatherData = WeatherData().obs;
  final RxBool isDarkMode = false.obs;
  final RxBool isFahrenheit = false.obs;

  // final city = City().obs;

  RxBool checkStatus([WeatherData? cityWeatherData]) => _isLoading;
  RxDouble getlat() => _lat;
  RxDouble getlng() => _lng;
  WeatherData getWeatherData([String? city]) => weatherData.value;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  RxInt getIndex() => cardIndex;
  // getLocation() async {
  //   bool isEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!isEnabled) return Future.error('Service is not enabled');
//
  //   LocationPermission locationP = await Geolocator.checkPermission();
  //   if (locationP == LocationPermission.deniedForever) {
  //     Future.error('Service denied forever');
  //   } else if (locationP == LocationPermission.denied) {
  //     locationP = await Geolocator.requestPermission();
  //     if (locationP == LocationPermission.denied) {
  //       Future.error('Service denied');
  //     }
  //   }
//
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((value) {
  //     _lat.value = value.latitude;
  //     _lng.value = value.longitude;
//
  //     return fetchData()
  //         .getData(_lat.value, _lng.value,
  //             unit)
  //         .then((value) {
  //       weatherData.value = value;
  //       _isLoading.value = false;
  //     });
  //     // commented on the 13th January 2024 08:05 am
  //     // return fetchData().getData(_lat.value, _lng.value).then((value) {
  //     //   weatherData.value = value;
  //     //   _isLoading.value = false;
  //     // });
  //   });
  // }
//
  // Future<void> getDataForCity(String cityName) async {
  //   try {
  //     WeatherData cityWeatherData = await fetchData().getDataForCity(cityName);
  //     checkStatus(cityWeatherData);
  //   } catch (e) {
  //     print('Error fetching weather data for $cityName: $e');
  //     // Handle the error if fetching data fails
  //   }
  // }

  Future<void> getLocation({TemperatureUnit? unit}) async {
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return Future.error('Service is not enabled');

    LocationPermission locationP = await Geolocator.checkPermission();
    if (locationP == LocationPermission.deniedForever) {
      Future.error('Service denied forever');
    } else if (locationP == LocationPermission.denied) {
      locationP = await Geolocator.requestPermission();
      if (locationP == LocationPermission.denied) {
        Future.error('Service denied');
      }
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((value) {
      _lat.value = value.latitude;
      _lng.value = value.longitude;

      return fetchData()
          .getData(_lat.value, _lng.value, unit ?? TemperatureUnit.celsius)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  Future<void> getDataForCity(String cityName, TemperatureUnit unit) async {
    try {
      WeatherData cityWeatherData =
          await fetchData().getDataForCity(cityName, unit);
      checkStatus(cityWeatherData);
    } catch (e) {
      print('Error fetching weather data for $cityName: $e');
      // Handle the error if fetching data fails
    }
  }
}
