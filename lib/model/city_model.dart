import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name;

  const City({
    required this.name,
  });
  
  @override
  List<Object?> get props => [name];
}
