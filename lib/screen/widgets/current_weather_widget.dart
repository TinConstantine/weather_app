import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cutbit/cubits/weather_cubbit.dart';
import 'package:weather_app_cutbit/models/weather_data.dart';
import 'package:weather_app_cutbit/services/custom_colors.dart';
import 'package:weather_app_cutbit/states/weather_state.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WeatherCubit>().getCurrentWeather();
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, weatherState) {
        if (weatherState is WeatherStateFailure) {
          return Text(weatherState.message);
        } else if (weatherState is WeatherStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (weatherState is WeatherStateSuccess) {
          return Column(
            children: [
              //temp area
              tempeatureAreaWidget(weatherState.weatherData),
              const SizedBox(
                height: 20,
              ),
              currentWeatherMoreDetailsWidget(weatherState.weatherData),
            ],
          );
        }
        return const Center(
          child: Text('Something was wrong!'),
        );
      },
    );
  }

  Widget currentWeatherMoreDetailsWidget(WeatherData weatherData) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/icons/windspeed.png'),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/icons/clouds.png'),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/icons/humidity.png'),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherData.getCurrentWeather().current.windSpeed}km/h',
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherData.getCurrentWeather().current.clouds}%',
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherData.getCurrentWeather().current.humidity}%',
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget tempeatureAreaWidget(WeatherData weatherData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          'assets/weather/${weatherData.getCurrentWeather().current.weather![0].icon}.png',
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '${weatherData.getCurrentWeather().current.temp!.toInt()}°',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 68,
                  color: CustomColors.textColorBlack)),
          TextSpan(
              text:
                  '${weatherData.getCurrentWeather().current.weather![0].description}',
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: CustomColors.textColorBlack)),
        ])),
      ],
    );
  }
}
