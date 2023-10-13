import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app_cutbit/cubits/weather_cubbit.dart';
import 'package:weather_app_cutbit/services/custom_colors.dart';
import 'package:weather_app_cutbit/states/weather_state.dart';

class ComfortLevel extends StatelessWidget {
  const ComfortLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, weatherState) {
        if (weatherState is WeatherStateSuccess) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 1, left: 20, right: 20, bottom: 20),
                child: const Text(
                  'Comfort Level',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 180,
                child: Column(
                  children: [
                    Center(
                      child: SleekCircularSlider(
                        min: 0,
                        max: 100,
                        initialValue: weatherState.weatherData
                            .getCurrentWeather()
                            .current
                            .humidity!
                            .toDouble(),
                        appearance: CircularSliderAppearance(
                            customWidths: CustomSliderWidths(
                                handlerSize: 0, trackWidth: 12),
                            infoProperties: InfoProperties(
                                bottomLabelText: "Humidity",
                                bottomLabelStyle: const TextStyle(
                                    letterSpacing: 0.1,
                                    fontSize: 14,
                                    height: 1.5)),
                            animationEnabled: true,
                            size: 140,
                            customColors: CustomSliderColors(
                                trackColor: CustomColors.firstGradientColor
                                    .withAlpha(100),
                                hideShadow: true,
                                progressBarColors: [
                                  CustomColors.firstGradientColor,
                                  CustomColors.secondGradientColor
                                ])),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Feels like ",
                              style: TextStyle(
                                  fontSize: 14,
                                  height: 0.8,
                                  color: CustomColors.textColorBlack,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text:
                                  "${weatherState.weatherData.getCurrentWeather().current.feelsLike}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  height: 0.8,
                                  color: CustomColors.textColorBlack,
                                  fontWeight: FontWeight.w400))
                        ])),
                        Container(
                          margin: const EdgeInsets.only(left: 40, right: 40),
                          height: 25,
                          width: 1,
                          color: CustomColors.dividerLine,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "UV Index ",
                              style: TextStyle(
                                  fontSize: 14,
                                  height: 0.8,
                                  color: CustomColors.textColorBlack,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text:
                                  "${weatherState.weatherData.getCurrentWeather().current.uvIndex}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  height: 0.8,
                                  color: CustomColors.textColorBlack,
                                  fontWeight: FontWeight.w400))
                        ])),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        }
        return const Center(
          child: Text(''),
        );
      },
    );
  }
}
