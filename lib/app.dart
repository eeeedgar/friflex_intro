import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/ui/pages/weather_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/city/city_bloc.dart';
import 'ui/pages/enter_city_page.dart';

class FliflexIntroApp extends StatefulWidget {
  const FliflexIntroApp({super.key});

  @override
  State<FliflexIntroApp> createState() => _FliflexIntroAppState();
}

class _FliflexIntroAppState extends State<FliflexIntroApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // нужно отслеживать состояние выбора города (выбран/не выбран)
      providers: [
        BlocProvider(
          create: (context) => CityBloc()..add(LoadCity()), // при старте приложения попробуем загрузить город из Shared References
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
              return const WeatherPage();
            } else {
              return const FillCityPage(); // здесь будем ждать, когда город загрузится/не загрузится или будем указывать его сами
            }
          },
        ),
      ),
    );
  }
}
