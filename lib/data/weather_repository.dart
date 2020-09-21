import 'dart:math';

import 'package:flutter_bloc_library/data/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
  Future<Weather> fetchDetailWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  double cachedTempCelsius;

  @override
  Future<Weather> fetchWeather(String cityName) {
    // simulate network delay
    return Future.delayed(Duration(seconds: 1), () {
      final random = Random();

      // simulate some network error
      if (random.nextBool()) {
        throw NetworkError();
      }

      cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

      return Weather(cityName: cityName, temperatureCelsius: cachedTempCelsius);
    });
  }

  @override
  Future<Weather> fetchDetailWeather(String cityName) {
    // simulate network delay
    return Future.delayed(Duration(seconds: 1), () {
      return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius,
          temperatureFahrenheit: cachedTempCelsius * 1.8 + 32);
    });
  }
}

class NetworkError extends Error {}
