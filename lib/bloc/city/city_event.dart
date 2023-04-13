part of 'city_bloc.dart';

@immutable
abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class LoadCity extends CityEvent {}

class FillCity extends CityEvent {
  final City city;

  const FillCity(this.city);

  @override
  List<Object> get props => [city];
}

class RemoveCity extends CityEvent {}
