import 'package:flutter/material.dart';

class CityCardTile extends StatelessWidget {
  final List<String> cityNames;
  final Function(String) onTap;

  const CityCardTile({super.key, required this.cityNames, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cityNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTap(cityNames[index]);
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cityNames[index],
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
