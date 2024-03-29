/// converts values of type int to double
/// intended to use while parsing json values where type will be dynamic
/// returns value of type double

// commented on the 13 January 2024 09:40 am
// intToDouble(dynamic val) {
//   if (val is double) {
//     return val;
//   } else if (val is int) {
//     return val.toDouble();
//   } else {
//     throw Exception(
//         "value is not of type 'int' or 'double' got type '${val.runtimeType}'");
//   }
// }

// Before on the 13th January 2024
// intToDouble(dynamic val) {
//   if (val.runtimeType == double) {
//     return val;
//   } else if (val.runtimeType == int) {
//     return val.toDouble();
//   } else {
//     throw Exception(
//         "value is not of type 'int' or 'double' got type '${val.runtimeType}'");
//   }
// }

enum TemperatureUnit { kelvin, celsius, fahrenheit }

class Temperature {
  final double _kelvin;

  Temperature(this._kelvin);

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;

  double as(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return kelvin;
      // break;
      case TemperatureUnit.celsius:
        return celsius;
      // break;
      case TemperatureUnit.fahrenheit:
        return fahrenheit;
      // break;
    }
    // return fahrenheit;
  }
}
