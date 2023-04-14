import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/model/weather_model.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../../util/app_colors.dart';
import '../weather/weather_tile.dart';

class WeatherForSeveralDaysPage extends StatefulWidget {
  const WeatherForSeveralDaysPage({super.key});

  @override
  State<WeatherForSeveralDaysPage> createState() =>
      _WeatherForSeveralDaysPageState();
}

class _WeatherForSeveralDaysPageState extends State<WeatherForSeveralDaysPage> {
  final List<Weather> _weatherSlice = List.empty(growable: true);
  late int _minTemperatureIndex;

  @override
  void initState() {
    super.initState();
    final state = context.read<WeatherBloc>().state as WeatherSuccess;

    final closestEvent = state
        .weather.first; // будем отмерять 3 дня от ближайшей записи в прогнозе

    const threeDaysInSeconds = 259200; // 3 дня в секундах

    var i = 0;
    while (i < state.weather.length &&
        state.weather[i].timestamp - closestEvent.timestamp <
            threeDaysInSeconds) {
      _weatherSlice.add(state.weather[i]);
      i++;
    }

    var minTemperature = _weatherSlice.first
        .temperature; // будем искать самый холодный момент среди ближайших трех дней
    _minTemperatureIndex = 0;
    for (var i = 1; i < _weatherSlice.length; i++) {
      if (_weatherSlice[i].temperature < minTemperature) {
        minTemperature = _weatherSlice[i].temperature;
        _minTemperatureIndex = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<WeatherBloc>().state as WeatherSuccess;
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
          elevation: 0,
          title: Text(
            state.city.name,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.blue,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: ListView.builder(
        itemCount: _weatherSlice.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              title: WeatherRow(
                weather: _weatherSlice[_minTemperatureIndex],
                icon: state.icons[_weatherSlice[_minTemperatureIndex].icon]!,
                isColdest: true,
              ),
            );
          }
          return ListTile(
            title: WeatherRow(
              weather: _weatherSlice[index - 1],
              icon: state.icons[_weatherSlice[index - 1].icon]!,
            ),
          );
        },
      ),
    );
  }
}
