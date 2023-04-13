import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:friflex_intro/model/weather_model.dart';
import 'package:http/http.dart';

class WeatherRepository {
  final String _baseUri = 'openweathermap.org';

  Future<List<Weather>> getWeather(String city) async {
    const methodUri = '/data/2.5/forecast';
    final queryParameters = {
      'q': city,
      'appId': dotenv.env['OpenWeather_API_KEY'],
    };

    var uri = Uri.http('api.$_baseUri', methodUri, queryParameters);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['list'];
      return result.map((e) => Weather.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Map<String, Image> getIcons(Set<String> iconIds) {
    const methodUriFirst = '/img/wn/';
    const methodUriLast = '@2x.png';
    final map = <String, Image>{};

    for (var id in iconIds) {
      Image icon =
          Image.network('https://$_baseUri$methodUriFirst$id$methodUriLast');
      map.putIfAbsent(id, () => icon);
    }

    return map;
  }
}
