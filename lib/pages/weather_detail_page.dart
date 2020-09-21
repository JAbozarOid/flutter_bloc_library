import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_library/data/model/weather.dart';
import 'package:flutter_bloc_library/bloc/bloc.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather masterWeather;

  const WeatherDetailPage({Key key, @required this.masterWeather})
      : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)
      ..add(GetDetailWeather(widget.masterWeather.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Detail'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildColumnWithData(context, state.weather);
          }
        }),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          "${weather.temperatureCelsius.toStringAsFixed(1)} C",
          style: TextStyle(fontSize: 80),
        ),
         Text(
          "${weather.temperatureFahrenheit.toStringAsFixed(1)} C",
          style: TextStyle(fontSize: 80),
        ),
      ],
    );
  }
}
