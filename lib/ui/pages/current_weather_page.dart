import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/ui/pages/weather_for_several_days_page.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../bloc/city/city_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(LoadWeatherEvent(
        city: (context.read<CityBloc>().state as CitySpecifiedState).city));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          context.read<CityBloc>().add(EditCityEvent());
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: const Text('show'),
        // onPressed: () => Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const WeatherForSeveralDaysPage(),
        //   ),
        // ),
        onPressed: () => Navigator.of(context).push(SwipeablePageRoute(
          builder: (BuildContext context) => const WeatherForSeveralDaysPage(),
        )),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
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
                  title:
                      Text('Температура: ${state.weather[index].temperature}'),
                  subtitle: Text(
                      '${DateTime.fromMillisecondsSinceEpoch(state.weather[index].timestamp)}'),
                );
              },
            );
          } else {
            return const Center(child: Text('error'));
          }
        },
      ),
    );
  }
}
