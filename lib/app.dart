import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/city/city_bloc.dart';
import 'bloc/network/network_bloc.dart';
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
          create: (context) => CityBloc()..add(LoadCity()),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
        BlocProvider(
          create: (context) => NetworkBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 0.7,
              ),
        ),
        home: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityFilled) {
              return const CurrentWeatherPage();
            } else {
              return const FillCityPage();
            }
          },
        ),
      ),
    );
  }
}
