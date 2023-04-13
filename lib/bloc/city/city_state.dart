part of 'city_bloc.dart';

@immutable
abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

class CityLoadingState extends CityState {}

class CityEditingState extends CityState {
  final City? city;

  const CityEditingState({this.city});

  @override
  List<Object?> get props => [city];
}

class CitySpecifiedState extends CityState {
  final City city;

  const CitySpecifiedState({required this.city});

  @override
  List<Object?> get props => [city];
}
