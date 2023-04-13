import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/city/city_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../model/city_model.dart';

class LoadCityScreen extends StatelessWidget {
  const LoadCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}

class EnterCityScreen extends StatefulWidget {
  const EnterCityScreen({super.key});

  @override
  State<EnterCityScreen> createState() => _EnterCityScreenState();
}

class _EnterCityScreenState extends State<EnterCityScreen> {
  final _cityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cityNameController.text =
        (context.read<CityBloc>().state as CityEditingState).city?.name ?? '';
  }

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _cityNameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter city',
              ),
            ),
            MaterialButton(
              child: const Text('Submit'),
              onPressed: () {
                context.read<CityBloc>().add(
                      EnterCityEvent(
                        City(name: _cityNameController.text),
                      ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
