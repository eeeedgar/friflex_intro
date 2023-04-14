import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/ui/pages/weather_for_several_days_page.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../bloc/city/city_bloc.dart';
import '../../bloc/network/network_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../util/app_colors.dart';
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
      backgroundColor: AppColors.blue,
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
            if (state is WeatherSuccess && state.weather.isNotEmpty) {
              return Column(
                children: [
                  Text(
                    'Weather forecast for ${Converter.epochToTimeHHMM(state.weather.first.timestamp)}',
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
                            (Converter.kelvinToCelsius(
                                state.weather.first.temperature)),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('Feels ${Converter.kelvinToCelsius((context.read<WeatherBloc>().state as WeatherSuccess).weather.first.feelsLike)}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      state.weather.first.main,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Pressure'),
                          SizedBox(height: 8),
                          Text('Humidity'),
                          SizedBox(height: 8),
                          Text('Wind'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Converter.pressureToMmgh(
                              state.weather.first.pressure)),
                              const SizedBox(height: 8),
                          Text(
                              Converter.humidity(state.weather.first.humidity)),
                              const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                Converter.windSpeed(
                                  state.weather.first.windSpeed,
                                ),
                              ),
                              Converter.windArrow(
                                state.weather.first.windDegree,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: MaterialButton(
                      color: Colors.blueAccent,
                      onPressed: () => Navigator.of(context).push(
                        SwipeablePageRoute(
                          builder: (BuildContext context) =>
                              const WeatherForSeveralDaysPage(),
                        ),
                      ),
                      child: const Text('Forecast for 3 days',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white70,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showErrorSnackBar() {
    if (!_errorIsShown) {
      _errorIsShown = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: ShapeBorder.lerp(null, null, 10),
          backgroundColor: Colors.white.withOpacity(0.2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height / 2,
            left: 50,
            right: 50,
          ),
          content: const Text(
            "Error receiving data",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.blue,
      elevation: 0,
      title: Text(
        (context.read<CityBloc>().state as CityFilled).city.name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          context.read<CityBloc>().add(RemoveCity());
        },
      ),
    );
  }
}
