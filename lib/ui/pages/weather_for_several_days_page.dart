import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../weather/weather_tile.dart';

class WeatherForSeveralDaysPage extends StatelessWidget {
  const WeatherForSeveralDaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = (context.read<WeatherBloc>().state as WeatherSuccess);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )),
      body: Column(
        children: [
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            color: Colors.indigo,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'The lowest temperature',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: WeatherRow(
                      weather: state.weather[0],
                      icon: state.icons[state.weather[0].icon]!),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.weather.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: WeatherRow(
                    weather: state.weather[index],
                    icon: state.icons[state.weather[index].icon]!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
