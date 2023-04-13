import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/city_model.dart';
import '../../util/helper.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial()) {
    on<LoadCity>(
      (event, emit) async {
        if (state is CityInitial) {
          final prefs = await SharedPreferences.getInstance();
          String? cityName = prefs.getString('cityName');
          if (cityName == null) {
            emit(CityEmpty(key: Helper.getRandomIntKey()));
          } else {
            emit(CityFilled(key: Helper.getRandomIntKey(), city: City(name: cityName)));
          }
        }
      },
    );
    on<FillCity>(
      (event, emit) async {
        if (state is CityEmpty) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('cityName', event.city.name);
          emit(
            CityFilled(key: Helper.getRandomIntKey(), city: event.city),
          );
        }
      },
    );
    on<RemoveCity>(
      (event, emit) async {
        if (state is CityFilled) {
          final prefs = await SharedPreferences.getInstance();
          prefs.remove('cityName');
          emit(
            CityEmpty(key: Helper.getRandomIntKey()),
          );
        }
      },
    );
  }
}
