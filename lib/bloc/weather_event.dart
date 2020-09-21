part of 'weather_bloc.dart';

// which actions or events from the UI will need to trigger some logic?
// in this case when user input the city name into the textfield
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

// the only event in this app is for getting the weather
class GetWeather extends WeatherEvent {
  final String cityName;

  // equatable allows for a simple value equality in Dart
  // All you need to do is to pass the class fields to the super constructor
  const GetWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class GetDetailWeather extends WeatherEvent {
  final String cityName;

  const GetDetailWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}
