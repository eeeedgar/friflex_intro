part of 'city_bloc.dart';

@immutable
abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class LoadCity extends CityEvent {} // когда грузим значение города из памяти

class FillCity extends CityEvent { // когда заполнили значение города (не важно - из памяти или сами ввели)
  final City city;

  const FillCity(this.city);

  @override
  List<Object> get props => [city];
}

class RemoveCity extends CityEvent {} // когда решили стереть значение города и ввести новый
