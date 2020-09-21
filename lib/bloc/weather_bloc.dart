import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_library/data/model/weather.dart';
import 'package:flutter_bloc_library/data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    // TODO: add logic
    // stream means the sequence of objects
    // then we can listen to the streams inside the UI and update the UI when the states outputed

    // yield convert outputed object to stream immediately after that we get the data from the fake weather api
    yield WeatherLoading();

    // Distinguish between different events, even though this app has only one
    if (event is GetWeather) {
      // outputing a state from the asynchronous generator

      // because meybe we have an error when calling fake api
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError("Coudn't fetch weather");
      }
    } else if(event is GetDetailWeather) {
      try{
        final weatherDetail = await weatherRepository.fetchDetailWeather(event.cityName);
        yield WeatherLoaded(weatherDetail);
      } on NetworkError {
        yield WeatherError("Coudn't fetch weather");
      }
    }
  }
}
