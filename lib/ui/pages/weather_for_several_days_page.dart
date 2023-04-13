import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../weather/weather_tile.dart';

class WeatherForSeveralDaysPage extends StatelessWidget {
  const WeatherForSeveralDaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = (context.read<WeatherBloc>().state as WeatherLoadedState);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )),
      body: ListView.builder(
        itemCount: state.weather.length,
        itemBuilder: (context, index) {
          return WeatherTile(
            weather: state.weather[index],
            icon: state.icons[state.weather[index].icon]!,
          );
        },
      ),
    );
  }
}
