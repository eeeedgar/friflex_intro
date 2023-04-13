part of 'city_bloc.dart';

@immutable
abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class LoadCityEvent extends CityEvent {}

class EnterCityEvent extends CityEvent {
  final City city;

  const EnterCityEvent(this.city);

  @override
  List<Object> get props => [city];
}

class EditCityEvent extends CityEvent {}
