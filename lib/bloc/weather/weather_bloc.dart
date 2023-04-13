import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friflex_intro/repo/weather_repository.dart';

import '../../model/city_model.dart';
import '../../model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<LoadWeatherEvent>(
      (event, emit) async {
        if (state is WeatherInitialState) {
          try {
            var weather = await WeatherRepository().getWeather(event.city.name);
            emit(
              WeatherLoadedState(
                city: event.city,
                weather: weather,
              ),
            );
          } catch (e) {
            emit(WeatherErrorState());
          }
        }
      },
    );
  }
}
