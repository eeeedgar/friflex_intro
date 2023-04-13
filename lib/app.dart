import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/city/city_bloc.dart';
import 'bloc/weather/weather_bloc.dart';
import 'ui/pages/current_weather_page.dart';
import 'ui/pages/enter_city_page.dart';

class FliflexIntroApp extends StatefulWidget {
  const FliflexIntroApp({super.key});

  @override
  State<FliflexIntroApp> createState() => _FliflexIntroAppState();
}

class _FliflexIntroAppState extends State<FliflexIntroApp> {
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
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   colorSchemeSeed: Colors.indigo,
        //   useMaterial3: true,
        // ),
        theme: ThemeData(
          useMaterial3: true,
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 0.7,
              ),
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
