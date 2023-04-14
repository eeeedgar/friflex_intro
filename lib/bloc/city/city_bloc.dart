import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/city_model.dart';
import '../../util/helper.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial()) { // начинаем работать с initial
    on<LoadCity>(
      (event, emit) async { // метод async, поэтому приходилось рисовать круги
        if (state is CityInitial) {
          final prefs = await SharedPreferences.getInstance(); // непосредственно пытаемся достать значение из памяти
          String? cityName = prefs.getString('cityName');
          if (cityName == null) { // не достали - вводим сами
            emit(CityEmpty(key: Helper.getRandomIntKey()));
          } else { // достали - пойдем смотреть погоду
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
          ); // когда заполняем город новым значением и идем смотреть погоду
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
          ); // когда город у нас указан и мы хотим его удалить/переписать
        }
      },
    );
  }
}
