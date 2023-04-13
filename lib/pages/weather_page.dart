import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/city/city_bloc.dart';
import '../bloc/weather/weather_bloc.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                context.read<CityBloc>().add(EditCityEvent());
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc()
              ..add(LoadWeatherEvent(
                  city: (context.read<CityBloc>().state as CitySpecifiedState)
                      .city)),
          ),
        ],
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoadedState) {
              return ListView.builder(
                itemCount: state.weather.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(
                          'Температура: ${state.weather[index].temperature}'));
                },
              );
            } else {
              return const Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }
}
