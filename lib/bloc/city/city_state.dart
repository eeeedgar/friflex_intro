part of 'city_bloc.dart';

@immutable
abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

class CityInitial extends CityState {}

class CityEmpty extends CityState {
  final int key;

  const CityEmpty({required this.key});

  @override
  List<Object?> get props => [key];
}

class CityFilled extends CityState {
  final int key;
  final City city;

  const CityFilled({required this.key, required this.city});

  @override
  List<Object?> get props => [key, city];
}
