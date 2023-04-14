part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class CheckNetwork extends NetworkEvent {}

// событие всего одно - потому что мы в силах только проверить интернет