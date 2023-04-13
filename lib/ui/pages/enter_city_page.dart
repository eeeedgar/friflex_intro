import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_intro/bloc/weather/weather_bloc.dart';

import '../../bloc/city/city_bloc.dart';
import '../../bloc/network/network_bloc.dart';
import '../../model/city_model.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Get weather forecast'),
        onPressed: () {
          context.read<CityBloc>().add(
                FillCity(City(name: _cityNameController.text)),
              );
          context.read<WeatherBloc>().add(
                LoadWeather(city: City(name: _cityNameController.text)),
              );
          context.read<NetworkBloc>().add(
                CheckNetwork(),
              );
        },
      ),
      body: Center(
        child: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityInitial) {
              return const CircularProgressIndicator();
            } // state is CityEmpty
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _cityNameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter city',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
