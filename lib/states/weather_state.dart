// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import '../models/weather_data.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherStateFailure extends WeatherState {
  String message;
  WeatherStateFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  WeatherData weatherData;
  WeatherStateSuccess({
    required this.weatherData,
  });
  @override
  List<Object> get props => [weatherData];
}
