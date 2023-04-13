import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/ui/pages/weather_for_several_days_page.dart';
import 'package:friflex_intro/util/helper.dart';
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
  bool _errorIsShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is NetworkFailure) {
            _showErrorSnackBar();
          }
        },
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherFailure) {
              _showErrorSnackBar();
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
                  MaterialButton(
                    onPressed: () => Navigator.of(context).push(
                      SwipeablePageRoute(
                        builder: (BuildContext context) =>
                            const WeatherForSeveralDaysPage(),
                      ),
                    ),
                    child: const Text('Forecast for 3 days'),
                  )
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

  void _showErrorSnackBar() {
    if (!_errorIsShown) {
      _errorIsShown = true;
      ScaffoldMessenger.of(context).showSnackBar(Helper.snackBar(context));
    }
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
        child: const Center(child: Text('Choose city')),
        onPressed: () {
          context.read<CityBloc>().add(RemoveCity());
        },
      ),
    );
  }
}
