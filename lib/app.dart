import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return MultiBlocProvider( // нужно отслеживать три состояния: город выбран/не выбран, погода, состояние сети
      providers: [  // все три блока положим сюда, чтобы в дальнейшем могли обращаться к ним из любой части приложения
        BlocProvider(
          create: (context) => CityBloc()..add(LoadCity()), // при старте приложения попробуем загрузить город из Shared References
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
          textTheme: GoogleFonts.rubikTextTheme(  // здесь указал шрифты, чтобы применились ко всем текстам
            Theme.of(context).textTheme,
          ).apply(bodyColor: Colors.white),
        ),
        home: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityFilled) { // когда город загрузится из памяти или мы сами его укажем - пойдем смотреть погоду
              return const CurrentWeatherPage();
            } else {
              return const FillCityPage(); // здесь будем ждать, когда город загрузится/не загрузится или будем указывать его сами
            }
          },
        ),
      ),
    );
  }
}
