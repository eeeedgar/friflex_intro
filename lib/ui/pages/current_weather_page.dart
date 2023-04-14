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
  bool _errorIsShown =
      false; // так как у нас отсутствие сети и ошибка в сервисе погоды дают
  //  одну и ту же ошибку (SnackBar), будем запоминать факт показа

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
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
            context
                .read<CityBloc>()
                .add(RemoveCity()); // переходим в состояние ввода города
            // по нажатию кнопки и возвращаемся на предыдущий экран
          },
        ),
      ),
      body: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is NetworkFailure) {
            // слушаем информацию о сети
            _showErrorSnackBar(); // если ошибка - SnackBar
          }
        },
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherFailure) {
              // с помощью блока погоды не только
              _showErrorSnackBar(); // отображаем SnackBar, но и строим дерево,
            } // поэтому нужен и Listener, и Builder
          }, // (SnackBar нельзя отобразить в дереве, поэтому обязательно нужны Listener'ы)
          builder: (context, state) {
            if (state is WeatherSuccess && state.weather.isNotEmpty) {
              // ответ могли и получить,
              return Column(
                // но если он пустой, нам с ним делать нечего, поэтому обработаем пустой ответ
                children: [
                  // как ошибку
                  Text(
                    'Weather forecast for ${Converter.epochToTimeHHMM(state.weather.first.timestamp)}',
                  ), // отформатируем время в читаемый вид
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: state.icons.entries.first.value.image,
                      ), // в этом дереве можем обращаться к стейту как к успешному и не кастить лишний раз
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (Converter.kelvinToCelsius(
                                state.weather.first.temperature)),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ('Feels ${Converter.kelvinToCelsius(state.weather.first.feelsLike)}'),
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
                              ), // это стрелка направления ветра
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
                        SwipeablePageRoute( // кнопка никакие состояния не меняет
                          builder: (BuildContext context) => // а просто переходит на другую страницу,
                              const WeatherForSeveralDaysPage(), // информация для которой у нас уже есть
                        ),
                      ), // обратно можем свайпать!
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

  void _showErrorSnackBar() { // SnackBar используется дважды (интернетом и погодой),
    if (!_errorIsShown) { //  поэтому не будем дублировать
      _errorIsShown = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: ShapeBorder.lerp(null, null, 10),
          backgroundColor: Colors.white.withOpacity(0.2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only( // сделаем его по центру, а не снизу
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
}
