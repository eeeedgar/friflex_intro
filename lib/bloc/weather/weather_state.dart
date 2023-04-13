part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final City city;
  final List<Weather> weather;
  final Map<String, Image> icons;

  const WeatherSuccess({
    required this.city,
    required this.weather,
    required this.icons,
  });

  @override
  List<Object> get props => [city, weather, icons];
}

class WeatherFailure extends WeatherState {
  final int key;

  const WeatherFailure({required this.key});

  @override
  List<Object> get props => [key];
}
