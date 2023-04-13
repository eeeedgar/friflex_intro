import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/ui/pages/weather_for_several_days_page.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../bloc/city/city_bloc.dart';
import '../../bloc/network/network_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../util/converter.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(),
      body: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is NetworkFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Network failure')));
          }
        },
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('API failure')));
            }
          },
          builder: (context, state) {
            if (state is WeatherSuccess) {
              return Column(
                children: [
                  Text(
                    'Weather forecast for ${Converter.epochToTimeHHMM((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.timestamp)}',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: (context.read<WeatherBloc>().state
                                as WeatherSuccess)
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
                                    .state as WeatherSuccess)
                                .weather
                                .first
                                .temperature)),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('Feels ${Converter.kelvinToCelsius((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.feelsLike)}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                      'Pressure: ${Converter.pressureToMmgh((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.pressure)}'),
                  Text(
                      'Humidity: ${Converter.humidity((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.humidity)}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Wind: ${Converter.windSpeed((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.windSpeed)}'),
                      Transform.rotate(
                          angle: Converter.windArrowAngle((context
                                  .read<WeatherBloc>()
                                  .state as WeatherSuccess)
                              .weather
                              .first
                              .windDegree),
                          child: const Icon(Icons.arrow_right_alt_rounded)),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _data() {
    return Column(
      children: [
        Text(
          'Weather forecast for ${Converter.epochToTimeHHMM((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.timestamp)}',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: (context.read<WeatherBloc>().state as WeatherSuccess)
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
                  (Converter.kelvinToCelsius(
                      (context.read<WeatherBloc>().state as WeatherSuccess)
                          .weather
                          .first
                          .temperature)),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ('Feels ${Converter.kelvinToCelsius((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.feelsLike)}'),
                ),
              ],
            ),
          ],
        ),
        Text(
            'Pressure: ${Converter.pressureToMmgh((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.pressure)}'),
        Text(
            'Humidity: ${Converter.humidity((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.humidity)}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Wind: ${Converter.windSpeed((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.windSpeed)}'),
            Transform.rotate(
                angle: Converter.windArrowAngle(
                    (context.read<WeatherBloc>().state as WeatherSuccess)
                        .weather
                        .first
                        .windDegree),
                child: const Icon(Icons.arrow_right_alt_rounded)),
          ],
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        (context.read<CityBloc>().state as CityFilled).city.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      leadingWidth: 100,
      leading: MaterialButton(
        child: const Center(child: Text('Edit city')),
        onPressed: () {
          context.read<CityBloc>().add(RemoveCity());
        },
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton.extended(
      label: const Text('Forecast for 3 days'),
      onPressed: () => Navigator.of(context).push(
        SwipeablePageRoute(
          builder: (BuildContext context) => const WeatherForSeveralDaysPage(),
        ),
      ),
    );
  }
}
