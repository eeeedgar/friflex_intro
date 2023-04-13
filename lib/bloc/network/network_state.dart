part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState {}

class NetworkSuccess extends NetworkState {
  final int key;

  const NetworkSuccess({required this.key});

  @override
  List<Object> get props => [key];
}

class NetworkFailure extends NetworkState {
  final int key;

  const NetworkFailure({required this.key});

  @override
  List<Object> get props => [key];
}
