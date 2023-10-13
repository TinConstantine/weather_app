import 'dart:convert';

import 'package:weather_app_cutbit/models/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_cutbit/models/weather_data_current.dart';
import 'package:weather_app_cutbit/models/weather_data_daily.dart';
import 'package:weather_app_cutbit/models/weather_data_hourly.dart';
import 'package:weather_app_cutbit/services/api_key.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;
  Future<WeatherData> processData({lat, lon}) async {
    final response = await http.get(Uri.parse(apiUrl(lat: lat, lon: lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        current: WeatherDataCurrent.fromJson(jsonString),
        hourly: WeatherDataHourly.fromJson(jsonString),
        daily: WeatherDataDaily.fromJson(jsonString));

    return weatherData!;
  }
}

String apiUrl({lat, lon}) {
  return 'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely';
}
