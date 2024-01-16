import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_starter_project/provider/city_provider.dart';
import 'package:weatherapp_starter_project/screens/add_city_page.dart';
import 'package:weatherapp_starter_project/util/custom_colors.dart';

class CityManagerBottomNavBar extends StatelessWidget {
  const CityManagerBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CityProvider>(builder: (context, value, child) {
      return Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: size.width * 0.025),
          decoration: BoxDecoration(
            color: CustomColors.cardColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddCityPage()));
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () => value.changeEditStatus(),
                icon: const Icon(Icons.brush),
              ),
            ],
          ),
        ),
      );
    });
  }
}
