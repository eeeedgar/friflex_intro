import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:friflex_intro/repo/weather_repository.dart';

import '../../model/city_model.dart';
import '../../model/weather_model.dart';
import '../../util/helper.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<LoadWeather>(
      (event, emit) async {
        try {
          var weather = await WeatherRepository().getWeather(event.city.name);
          var icons = WeatherRepository().getIcons(_getUniqueIconIds(weather)); // использую из-за того, что много иконок повторятся,
          emit( //  а много качать не хочется
            WeatherSuccess(
              city: event.city,
              weather: weather,
              icons: icons,
            ),
          );
        } catch (e) {
          emit(WeatherFailure(key: Helper.getRandomIntKey()));
        }
      },
    );
  }

  Set<String> _getUniqueIconIds(List<Weather> weather) {
    final ids = <String>{}; // будем хранить иконки в словаре, потому что повторяться им смысла нет
    for (var w in weather) {
      ids.add(w.icon);
    }

    return ids;
  }
}
