import 'package:flutter/material.dart';

import '../../model/weather_model.dart';
import '../../util/converter.dart';

class WeatherRow extends StatelessWidget {
  final Weather weather;
  final Image icon;
  final bool isColdest;
  const WeatherRow({super.key, required this.weather, required this.icon, this.isColdest = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isColdest
      ? const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.white38)))
      : null, // украшение для самого холодного элемента
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 30,
            child: Text(
              Converter.epochToDay(weather.timestamp),
              style: const TextStyle(fontSize: 10),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              Converter.epochToTimeHHMM(weather.timestamp),
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              weather.main,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          SizedBox(
            width: 20,
            child: Text(
              Converter.kelvinToCelsius(weather.temperature),
              style: const TextStyle(fontSize: 10),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              Converter.windSpeed(weather.windSpeed),
              style: const TextStyle(fontSize: 10),
            ),
          ),
          Converter.windArrow(weather.windDegree),
          Image(
            alignment: Alignment.centerRight,
            image: icon.image,
            width: 30,
            height: 30,
            errorBuilder: (context, exception, stackTrace) {
              return const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(), // фотография может и не загрузиться... поэтому на всякий случай сделаем плейсхолдер
              );
            },
          )
        ],
      ),
    );
  }
}
