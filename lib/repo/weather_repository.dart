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
      'appId': dotenv.env['OpenWeather_API_KEY'], // получаем ключ апи из .env
    };

    var uri = Uri.http('api.$_baseUri', methodUri, queryParameters);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['list'];
      return _getWeatherForNDays(
          result.map((e) => Weather.fromJson(e)).toList(),
          3); // нужно инфы на три дня
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Map<String, Image> getIcons(Set<String> iconIds) {
    // иконки погоды часто повторяются, поэтому качать их отдельно бессмысленно
    const methodUriFirst =
        '/img/wn/'; // скачаем все различные, а обращаться будем к тому что сохранили
    const methodUriLast = '@2x.png';
    final map = <String, Image>{};

    for (var id in iconIds) {
      Image icon =
          Image.network('https://$_baseUri$methodUriFirst$id$methodUriLast');
      map.putIfAbsent(id, () => icon);
    }

    return map;
  }

  List<Weather> _getWeatherForNDays(List<Weather> source, int days) {
    // не будем хардкодить количество дней
    final threeDaysInSeconds = // с сервиса нам приходит слишком много погоды (дольше, чем на три дня)
        86400 *
            days; // столько секунд в трех сутках, а с сервиса нам приходят timestamp'ы
    final nDaysResult = List<Weather>.empty(growable: true);
    if (source.isEmpty) {
      throw Exception('Empty array');
    } // если элементов нет - выбросим исключение и поймаем в методе где вызвали (getWeather)
    final closestEvent = source
        .first; // первый элемент в ответе - ближайший по времени, будем считать три дня от него
    var i = 0;
    while (i <
            source
                .length && // в теории в ответе может и не хватить на три дня, поэтому обезопасимся
        source[i].timestamp - closestEvent.timestamp < threeDaysInSeconds) {
      nDaysResult.add(source[i]);
      i++;
    }

    return nDaysResult;
  }
}
