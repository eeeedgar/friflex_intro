import 'dart:math';

import 'package:flutter/material.dart';

class Converter { // класс чтобы приводить полученную DTO в красивый вид
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

  static DateTime epochToDateTime(int epoch) {
    return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
  }

  static String epochToTimeHHMM(int epoch) {
    final time = epochToDateTime(epoch);
    var minutes = '${time.minute}';
    if (minutes.length == 1) {
      minutes = '0$minutes';
    }
    return '${time.hour}:$minutes';
  }

  static String epochToDay(int epoch) {
    final time = epochToDateTime(epoch);
    return '${time.day}/${time.month}';
  }

  static Widget windArrow(double angle) {
    return Transform.rotate(
      angle: Converter.windArrowAngle(angle),
      child: const Icon(
        Icons.arrow_right_alt_rounded,
        color: Colors.white,
      ),
    );
  }
}
