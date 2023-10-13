import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cutbit/cubits/location_cubit.dart';
import 'package:weather_app_cutbit/cubits/weather_cubbit.dart';
import 'package:weather_app_cutbit/screen/widgets/current_weather_widget.dart';
import 'package:weather_app_cutbit/screen/widgets/daily_weather_widget.dart';
import 'package:weather_app_cutbit/screen/widgets/header_widget.dart';
import 'package:weather_app_cutbit/services/custom_colors.dart';
import 'package:weather_app_cutbit/states/location_state.dart';

import 'widgets/comfort_level.dart';
import 'widgets/hourly_weather_wiget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocationCubit>().getLocaion();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, locationState) {
            if (locationState is LocationStateLoading) {
              return Center(
                child: Image.asset(
                  'assets/icons/clouds.png',
                  height: 200,
                  width: 200,
                ),
              );
            } else if (locationState is LocationStateSuccess) {
              return BlocProvider(
                  create: (context) => WeatherCubit(
                      lat: locationState.lattitude,
                      lon: locationState.longitude),
                  child: Center(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        HeaderWidget(
                          lat: locationState.lattitude,
                          lon: locationState.longitude,
                        ),
                        //current temp
                        const CurrentWeatherWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        const HourlyWeatherWidget(),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        const DailyWeatherWidget(),
                        Container(
                          height: 1,
                          color: CustomColors.dividerLine,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const ComfortLevel()
                      ],
                    ),
                  ));
            } else if (locationState is LocationStateFailure) {
              return Text(locationState.message);
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
