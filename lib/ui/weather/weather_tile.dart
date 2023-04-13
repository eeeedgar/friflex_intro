import 'package:flutter/material.dart';

import '../../model/weather_model.dart';
import '../../util/converter.dart';

class WeatherRow extends StatelessWidget {
  final Weather weather;
  final Image icon;
  const WeatherRow({super.key, required this.weather, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 30,
          child: Text(
            Converter.epochToDay(weather.timestamp),
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            Converter.epochToTimeHHMM(weather.timestamp),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: 60,
          child: Text(weather.main),
        ),
        SizedBox(
          width: 20,
          child: Text(
            Converter.kelvinToCelsius(weather.temperature),
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            Converter.windSpeed(weather.windSpeed),
          ),
        ),
        Converter.windArrow(weather.windDegree),
        Image(
          alignment: Alignment.centerRight,
          image: icon.image,
          width: 30,
          height: 30,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        )
      ],
    );
  }
}
