import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_cutbit/cubits/weather_cubbit.dart';
import 'package:weather_app_cutbit/models/weather_data.dart';
import 'package:weather_app_cutbit/services/custom_colors.dart';
import 'package:weather_app_cutbit/states/weather_state.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, weatherState) {
        if (weatherState is WeatherStateSuccess) {
          return Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: const Text(
                  "Today",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              hourList(weatherState.weatherData),
            ],
          );
        }
        return const Text('');
      },
    );
  }

  Widget hourList(WeatherData weatherData) {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: weatherData.getHourlyWeather().hourly.length > 12
            ? 14
            : weatherData.getHourlyWeather().hourly.length,
        itemBuilder: (context, index) {
          final hourlyWeather = weatherData.getHourlyWeather().hourly;
          return GestureDetector(
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0.5, 0),
                        blurRadius: 30,
                        spreadRadius: 1,
                        color: CustomColors.dividerLine.withAlpha(50))
                  ],
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 240, 240, 240),
                    Color.fromARGB(255, 240, 240, 240),
                    // Color.fromARGB(255, 219, 234, 255),
                  ])),
              child: HourlyDetails(
                  temp: hourlyWeather[index].temp!.toInt(),
                  timeStamp: hourlyWeather[index].dt!,
                  weatherIcon: hourlyWeather[index].weather![0].icon!),
            ),
          );
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {super.key,
      required this.temp,
      required this.timeStamp,
      required this.weatherIcon});
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat("jm").format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp)),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            'assets/weather/$weatherIcon.png',
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text('$temp°'),
        )
      ],
    );
  }
}
