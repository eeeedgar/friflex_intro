class Weather {
  int? timestamp;

  double? temperature;
  double? feelsLike;
  double? minTemparature;
  double? maxTemparature;
  double? pressure;
  double? humidity;

  double? windSpeed;
  double? windDegree;

  Weather(
      {required this.timestamp,
      required this.temperature,
      required this.feelsLike,
      required this.minTemparature,
      required this.maxTemparature,
      required this.pressure,
      required this.humidity,
      required this.windSpeed,
      required this.windDegree});

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
  }
}
