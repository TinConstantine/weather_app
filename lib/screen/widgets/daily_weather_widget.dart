import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_cutbit/cubits/weather_cubbit.dart';
import 'package:weather_app_cutbit/models/weather_data.dart';
import 'package:weather_app_cutbit/services/custom_colors.dart';
import 'package:weather_app_cutbit/states/weather_state.dart';

class DailyWeatherWidget extends StatelessWidget {
  const DailyWeatherWidget({super.key});
  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, weatherState) {
        if (weatherState is WeatherStateSuccess) {
          return Container(
            height: 400,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: CustomColors.dividerLine.withAlpha(50),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 17),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Next Days",
                    style: TextStyle(
                        color: CustomColors.textColorBlack, fontSize: 17),
                  ),
                ),
                dailyList(weatherState.weatherData),
              ],
            ),
          );
        }
        return const Text('');
      },
    );
  }

  Widget dailyList(WeatherData weatherData) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: weatherData.getDailyWeather().daily.length > 7
            ? 7
            : weatherData.getDailyWeather().daily.length,
        itemBuilder: (context, index) {
          final daily = weatherData.getDailyWeather().daily;
          return Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        getDay(daily[index].dt),
                        style: const TextStyle(
                            color: CustomColors.textColorBlack, fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                          'assets/weather/${daily[index].weather![0].icon}.png'),
                    ),
                    Text(
                        "${daily[index].temp!.max!.toInt()}°/${daily[index].temp!.min!.toInt()}"),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: CustomColors.dividerLine,
              )
            ],
          );
        },
      ),
    );
  }
}
