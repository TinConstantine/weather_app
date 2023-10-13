import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cutbit/states/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationStateInitial());

  void getLocaion() async {
    final locationState = state;
    if (locationState is LocationStateInitial) {
      emit(LocationStateLoading());
      bool isServiceEnable = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnable) {
        emit(LocationStateFailure(message: 'Location not enable'));
      }
      // status permission
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        emit(LocationStateFailure(
            message: 'Location permission are denied forever'));
      } else if (locationPermission == LocationPermission.denied) {
        // request permission
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          emit(LocationStateFailure(message: 'Location permission is denied'));
        }
      }
      emit(await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) => LocationStateSuccess(
              lattitude: value.latitude, longitude: value.longitude)));
    }
  }
}
