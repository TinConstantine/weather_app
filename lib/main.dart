import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cutbit/cubits/location_cubit_observer.dart';
import 'package:weather_app_cutbit/screen/home_screen.dart';

import 'cubits/location_cubit.dart';

void main() {
  Bloc.observer = LocationCubitObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: BlocProvider(
        create: (context) => LocationCubit(),
        child: const HomeScreen(),
      )),
    );
  }
}
