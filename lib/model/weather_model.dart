import 'dart:convert';

class Weather {
  late int timestamp;
  late double feelsLike;
  late double minTemparature;
  late double maxTemparature;
  late double temperature;
  late double pressure;
  late double humidity;
  late double windSpeed;
  late double windDegree;
  late String icon;
  late String description;

  Weather(
      {required this.timestamp,
      required this.temperature,
      required this.feelsLike,
      required this.minTemparature,
      required this.maxTemparature,
      required this.pressure,
      required this.humidity,
      required this.windSpeed,
      required this.windDegree,
      required this.icon,
      required this.description});

  Weather.fromJson(Map<String, dynamic> json) {
    timestamp = json['dt'];

    temperature = double.parse(json['main']['temp'].toString());
    feelsLike = double.parse(json['main']['feels_like'].toString());
    minTemparature = double.parse(json['main']['temp_min'].toString());
    maxTemparature = double.parse(json['main']['temp_max'].toString());
    pressure = double.parse(json['main']['pressure'].toString());
    humidity = double.parse(json['main']['humidity'].toString());

    windSpeed = double.parse(json['wind']['speed'].toString());
    windDegree = double.parse(json['wind']['deg'].toString());

    icon = json['weather'][0]['icon'].toString();
    description = json['weather'][0]['description'].toString();
  }
}
