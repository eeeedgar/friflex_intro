class Weather {
  late int timestamp;
  late double feelsLike;
  late double minTemperature;
  late double maxTemperature;
  late double temperature;
  late double pressure;
  late double humidity;
  late double windSpeed;
  late double windDegree;
  late String icon;
  late String description;
  late String main;

  Weather(
      {required this.timestamp,
      required this.temperature,
      required this.feelsLike,
      required this.minTemperature,
      required this.maxTemperature,
      required this.pressure,
      required this.humidity,
      required this.windSpeed,
      required this.windDegree,
      required this.icon,
      required this.description,
      required this.main});

  Weather.fromJson(Map<String, dynamic> json) {
    timestamp = json['dt'];

    temperature = double.parse(json['main']['temp'].toString());
    feelsLike = double.parse(json['main']['feels_like'].toString());
    minTemperature = double.parse(json['main']['temp_min'].toString());
    maxTemperature = double.parse(json['main']['temp_max'].toString());
    pressure = double.parse(json['main']['pressure'].toString());
    humidity = double.parse(json['main']['humidity'].toString());

    windSpeed = double.parse(json['wind']['speed'].toString());
    windDegree = double.parse(json['wind']['deg'].toString());

    icon = json['weather'][0]['icon'].toString();
    description = json['weather'][0]['description'].toString();
    main = json['weather'][0]['main'].toString();
  }
}
