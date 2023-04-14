import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name; // название города обернул в класс. Думал, может возникнет необходимость искать не по названию,
  // а по коду, например. Но в обертке все равно поприятнее

  const City({
    required this.name,
  });
  
  @override // нужно для того, чтобы сравнивать объекты
  List<Object?> get props => [name];
}
