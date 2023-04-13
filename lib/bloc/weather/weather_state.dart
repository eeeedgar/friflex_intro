part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final City city;
  final List<Weather> weather;
  final Map<String, Image> icons;

  const WeatherLoadedState({
    required this.city,
    required this.weather,
    required this.icons,
  });

  @override
  List<Object> get props => [city, weather, icons];
}

class WeatherErrorState extends WeatherState {}
