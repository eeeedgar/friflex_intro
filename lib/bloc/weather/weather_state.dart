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

  const WeatherLoadedState({
    required this.city,
    required this.weather,
  });

  @override
  List<Object> get props => [city, weather];
}

class WeatherErrorState extends WeatherState {}
