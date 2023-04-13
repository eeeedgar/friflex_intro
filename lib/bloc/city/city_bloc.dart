import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/city_model.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityLoadingState()) {
    on<LoadCityEvent>(
      (event, emit) async {
        if (state is CityLoadingState) {
          final prefs = await SharedPreferences.getInstance();
          String? cityName = prefs.getString('cityName');
          if (cityName == null) {
            emit(
              const CityEditingState(city: City(name: '')),
            );
          } else {
            emit(
              CitySpecifiedState(city: City(name: cityName)),
            );
          }
        }
      },
    );
    on<EnterCityEvent>(
      (event, emit) async {
        if (state is CityEditingState) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('cityName', event.city.name);
          emit(
            CitySpecifiedState(city: event.city),
          );
        }
      },
    );
    on<EditCityEvent>(
      (event, emit) async {
        if (state is CitySpecifiedState) {
          final state = this.state as CitySpecifiedState;
          final prefs = await SharedPreferences.getInstance();
          prefs.remove('cityName');
          emit(
            CityEditingState(city: state.city),
          );
        }
      },
    );
  }
}
