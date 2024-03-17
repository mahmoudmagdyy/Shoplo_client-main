import 'package:equatable/equatable.dart';

abstract class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object> get props => [];
}

class CitiesInitial extends CitiesState {}

class GetCitiesLoadingState extends CitiesState {}

class GetCitiesLoadedState extends CitiesState {
  final dynamic data;
  const GetCitiesLoadedState(this.data);
  @override
  List<Object> get props => [data];
}

class GetCitiesErrorState extends CitiesState {
  final String error;
  const GetCitiesErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class GetCitiesEmpty extends CitiesState {}

class SetSelectedCityState extends CitiesState {}

class SetSelectedCategoryState extends CitiesState {}

class SetSelectedCategoryState1 extends CitiesState {}
