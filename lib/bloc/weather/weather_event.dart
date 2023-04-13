part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadWeather extends WeatherEvent {
  final City city;

  const LoadWeather({required this.city});

  @override
  List<Object> get props => [city];
}
