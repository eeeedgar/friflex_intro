import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/bloc/weather/weather_bloc.dart';

import '../../bloc/city/city_bloc.dart';
import '../../bloc/network/network_bloc.dart';
import '../../model/city_model.dart';
import '../../util/app_colors.dart';

class FillCityPage extends StatefulWidget {
  const FillCityPage({super.key});

  @override
  State<FillCityPage> createState() => _FillCityPageState();
}

class _FillCityPageState extends State<FillCityPage> {
  final _cityNameController = TextEditingController();

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Center(
        child: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityInitial) {
              return const CircularProgressIndicator();
            } // state is CityEmpty
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _cityNameController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white70),
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      labelText: 'Enter city',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      context.read<CityBloc>().add(
                            FillCity(City(name: _cityNameController.text)),
                          );
                      context.read<WeatherBloc>().add(
                            LoadWeather(
                                city: City(name: _cityNameController.text)),
                          );
                      context.read<NetworkBloc>().add(
                            CheckNetwork(),
                          );
                    },
                    child: const Text('Get weather forecast',
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
