part of 'city_bloc.dart';

@immutable
abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

class CityInitial extends CityState {} // initial - состояние, в котором оказываемся с самого начала (потому что так указали в блоке)

class CityEmpty extends CityState {
  final int key; // если город не указан - не получилось добыть из памяти или решили удалить сами

  const CityEmpty({required this.key});

  @override
  List<Object?> get props => [key];
}

class CityFilled extends CityState {
  final int key; // когда заполнили город значением
  final City city;

  const CityFilled({required this.key, required this.city});

  @override
  List<Object?> get props => [key, city];
}
