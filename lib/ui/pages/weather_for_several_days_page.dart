import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../weather/weather_tile.dart';

class WeatherForSeveralDaysPage extends StatefulWidget {
  const WeatherForSeveralDaysPage({super.key});

  @override
  State<WeatherForSeveralDaysPage> createState() =>
      _WeatherForSeveralDaysPageState();
}

class _WeatherForSeveralDaysPageState extends State<WeatherForSeveralDaysPage> {
  late int _minTemperatureIndex;

  @override
  void initState() {
    super.initState();
    final state = context.read<WeatherBloc>().state as WeatherSuccess;

    var minTemperature = state.weather.first
        .temperature; // будем искать самый холодный момент
    _minTemperatureIndex = 0;
    for (var i = 1; i < state.weather.length; i++) {
      if (state.weather[i].temperature < minTemperature) {
        minTemperature = state.weather[i].temperature;
        _minTemperatureIndex = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<WeatherBloc>().state as WeatherSuccess;
    return ListView.builder(
        itemCount: state.weather.length + 1, // самый холодный элемент (с самой холодной температурой) остался на своем хронологическом месте, просто я его еще вывел и наверху
        itemBuilder: (context, index) {
          if (index == 0) { // выводим первым (нулевым) номером
            return ListTile(
              title: WeatherRow(
                weather: state.weather[_minTemperatureIndex],
                icon: state.icons[state.weather[_minTemperatureIndex].icon]!,
                isColdest: true, // стилизуем его, чтобы не сливался
              ),
            );
          }
          return ListTile(
            title: WeatherRow(
              weather: state.weather[index - 1], // index - 1, потому что относительно ListView.
              icon: state.icons[state.weather[index - 1].icon]!, // а мы нулевым элементов поставили не нулевой в списке
            ),
          );
        },
      );
  }
}
