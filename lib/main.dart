import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_library/data/weather_repository.dart';
import 'package:flutter_bloc_library/pages/weather_search_page.dart';

import 'bloc/weather_bloc.dart';

void main() =>runApp(MyApp());


// UI has two roles:
// 1- Dispatch events to the bloc -> GetWeather events
// 2- React to states from the bloc

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}
