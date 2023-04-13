import 'package:flutter/material.dart';

import '../../model/weather_model.dart';

class WeatherTile extends StatelessWidget {
  final Weather weather;
  final Image icon;
  const WeatherTile({super.key, required this.weather, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(weather.description),
        icon
      ],),
    );
  }
}
