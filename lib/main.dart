import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/city/city_bloc.dart';
import 'pages/enter_city_page.dart';
import 'pages/weather_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CityBloc()..add(LoadCityEvent()),
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
              return const WeatherScreen();
            }
          },
        ),
      ),
    );
  }
}
