// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object> get props => [];
}

class LocationStateFailure extends LocationState {
  String message;
  LocationStateFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class LocationStateInitial extends LocationState {}

class LocationStateLoading extends LocationState {}

class LocationStateSuccess extends LocationState {
  double lattitude;
  double longitude;
  LocationStateSuccess({
    required this.lattitude,
    required this.longitude,
  });
  @override
  List<Object> get props => [lattitude, longitude];
}
