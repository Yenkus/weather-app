import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/data/city_provider.dart';

class CityMangerTiles extends StatelessWidget {
  const CityMangerTiles({
    super.key,
    required this.cityName,
    required this.weatherDegree,
    required this.index,
    // required this.edit,
  });

  final String cityName;
  final int weatherDegree;
  final int index;
  // final bool edit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CityProvider>(builder: (context, value, child) {
      return Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.04),
                child: Text(
                  cityName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.065,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: (value.edit == false)
                    ? Text(
                        '$weatherDegree°',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.065,
                        ),
                      )
                    : IconButton(
                        onPressed: () {}, // => value.deleteCity(index: index),
                        icon: const Icon(Icons.cancel_outlined),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
