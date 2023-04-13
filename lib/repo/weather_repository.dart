import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:friflex_intro/model/weather_model.dart';
import 'package:http/http.dart';

class WeatherRepository {
  String baseUri = 'api.openweathermap.org';

  Future<List<Weather>> getWeather(String city) async {
    const methodUri = '/data/2.5/forecast';
    final queryParameters = {
      'q': city,
      'appId': dotenv.env['OpenWeather_API_KEY'],
    };

    var uri = Uri.http(baseUri, methodUri, queryParameters);
    Response response = await get(uri);
  
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['list'];
      return result.map((e) => Weather.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
