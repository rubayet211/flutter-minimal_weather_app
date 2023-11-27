import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('a20ab0f17393d562ea772cf98224a264');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    try {
      //get current city
      String cityName = await _weatherService.getCurrentCity();

      //get weather for current city
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations

  String getWeatherCondition(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/day_rainy.json';
      case 'mist':
        return 'assets/misty.json';
      case 'rain':
        return 'assets/day_rainy.json';
      case 'snow':
        return 'assets/night_snow.json';
      case 'thunderstorm':
        return 'assets/day_thunder.json';
      case 'shower rain':
        return 'assets/day_rainy.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "Loading city..."),

            //animation
            Lottie.asset(getWeatherCondition(_weather?.mainCondition)),

            //temperature
            Text('${_weather?.temperature.round()}°C'),

            //condition
            Text(_weather?.mainCondition ?? " "),
          ],
        ),
      ),
    );
  }
}
