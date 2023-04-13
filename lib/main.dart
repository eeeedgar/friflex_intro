import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:friflex_intro/ui/pages/current_weather_page.dart';

import 'bloc/city/city_bloc.dart';
import 'bloc/weather/weather_bloc.dart';
import 'ui/pages/enter_city_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const FliflexIntro());
}

class FliflexIntro extends StatefulWidget {
  const FliflexIntro({super.key});

  @override
  State<FliflexIntro> createState() => _FliflexIntroState();
}

class _FliflexIntroState extends State<FliflexIntro> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CityBloc()..add(LoadCityEvent()),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4),
          useMaterial3: true,
        ),
        home: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityLoadingState) {
              return const LoadCityScreen();
            }
            if (state is CityEditingState) {
              return const EnterCityScreen();
            } else {
              // city is specified
              return const CurrentWeatherPage();
            }
          },
        ),
      ),
    );
  }
}
