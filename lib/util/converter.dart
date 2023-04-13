import 'dart:math';

class Converter {
  static String kelvinToCelsius(double temperature) {
    return '${(temperature - 273.15).toInt()}°';
  }

  static String humidity(double humidity) {
    return '${humidity.toInt()}%';
  }

  static String pressureToMmgh(double pressure) {
    return '${pressure ~/ 1.333} mmHg';
  }

  static double windArrowAngle(double degree) {
    return (90 + degree) * pi / 180;
  }

  static String windSpeed(double speed) {
    return '$speed m/s';
  }
}
