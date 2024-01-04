import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// A class that represents a city and its weather information
class City {
  final String name;
  final double temperature;
  final String condition;

  City(this.name, this.temperature, this.condition);
}

// A class that holds the list of cities and provides methods to add and remove cities
class CityProvider extends ChangeNotifier {
  bool edit = false;
  bool hasDataLoaded = false;

  void changeEditStatus() {
    edit = !edit;
    notifyListeners();
  }

  void changeDataStatus() {
    hasDataLoaded = true;

    notifyListeners();
  }


  List<City> _cities = [];
  Set<String> _cityNames = {}; // A set to store the city names and avoid duplicates

  List<City> get cities => _cities;

  void addCity(City city) {
    // Check if the city name is already in the set
    if (_cityNames.contains(city.name)) {
      // If yes, do not add the city and notify the listeners
      notifyListeners();
    } else {
      // If no, add the city to the list and the set and notify the listeners
      _cities.add(city);
      _cityNames.add(city.name);
      notifyListeners();
    }
  }

  void removeCity(City city) {
    // Remove the city from the list and the set and notify the listeners
    _cities.remove(city);
    _cityNames.remove(city.name);
    notifyListeners();
  }

  // A method to remove multiple cities from the list
  void removeCities(Set<City> cities) {
    // Remove each city from the list and the set and notify the listeners
    for (City city in cities) {
      _cities.remove(city);
      _cityNames.remove(city.name);
    }
    notifyListeners();
  }

  // // temporary list of cities
  // List cities = [
  //   ['Abuja', 31],
  //   ['Warri', 33],
  //   ['Lagos', 34],
  //   ['Portharcourt', 29],
  //   ['Benin', 32],
  // ];

  // void deleteCity({required int index}) {
  //   cities.removeAt(index);
  //   notifyListeners();
  // }
}
