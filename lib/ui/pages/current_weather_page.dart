import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/ui/pages/weather_for_several_days_page.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../bloc/city/city_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../util/converter.dart';

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
        title: Text(
          (context.read<CityBloc>().state as CitySpecifiedState).city.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            context.read<CityBloc>().add(EditCityEvent());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('show'),
        onPressed: () => Navigator.of(context).push(
          SwipeablePageRoute(
            builder: (BuildContext context) =>
                const WeatherForSeveralDaysPage(),
          ),
        ),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WeatherLoadedState) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: (context.read<WeatherBloc>().state
                              as WeatherLoadedState)
                          .icons
                          .entries
                          .first
                          .value
                          .image,
                      // height: 300,
                      // width: 300,
                      // fit: BoxFit.fill
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (Converter.kelvinToCelsius((context
                                  .read<WeatherBloc>()
                                  .state as WeatherLoadedState)
                              .weather
                              .first
                              .temperature)),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ('Feels ${Converter.kelvinToCelsius((context.read<WeatherBloc>().state as WeatherLoadedState).weather.first.feelsLike)}'),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                    'Pressure: ${Converter.pressureToMmgh((context.read<WeatherBloc>().state as WeatherLoadedState).weather.first.pressure)}'),
                Text(
                    'Humidity: ${Converter.humidity((context.read<WeatherBloc>().state as WeatherLoadedState).weather.first.humidity)}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Wind: ${Converter.windSpeed((context.read<WeatherBloc>().state as WeatherLoadedState).weather.first.windSpeed)}'),
                    Transform.rotate(
                        angle: Converter.windArrowAngle((context
                                .read<WeatherBloc>()
                                .state as WeatherLoadedState)
                            .weather
                            .first
                            .windDegree),
                        child: const Icon(Icons.arrow_right_alt_rounded)),
                  ],
                )
              ],
            );
          } else {
            return const Center(child: Text('error'));
          }
        },
      ),
    );
  }
}
