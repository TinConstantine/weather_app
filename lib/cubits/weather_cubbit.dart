import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app_cutbit/states/weather_state.dart';

import '../services/fetch_weather.dart';

class WeatherCubit extends Cubit<WeatherState> {
  double lat;
  double lon;
  WeatherCubit({required this.lat, required this.lon})
      : super(WeatherStateInitial());

  getCurrentWeather() async {
    final weatherState = state;

    try {
      if (weatherState is WeatherStateInitial) {
        emit(WeatherStateLoading());
        final weatherData =
            await FetchWeatherAPI().processData(lat: lat, lon: lon);
        emit(WeatherStateSuccess(weatherData: weatherData));
      }
    } catch (_) {
      emit(WeatherStateFailure(message: 'Something was wrong!'));
    }
  }
}
