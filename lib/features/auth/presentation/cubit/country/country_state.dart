part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

// GetCountries states

class GetCountriesLoadingState extends CountryState {}

class SetSelectedCountryState extends CountryState {}

class SetSelectedCategoryState extends CountryState {}

class SetSelectedCategoryState1 extends CountryState {}

class GetCountriesLoadedState extends CountryState {
  final List<dynamic> data;
  const GetCountriesLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class GetCountriesErrorState extends CountryState {
  final String error;
  const GetCountriesErrorState(this.error);
}

// GetStates states
class GetStatesLoadingState extends CountryState {}

class GetStatesLoadedState extends CountryState {
  final List<dynamic> data;
  const GetStatesLoadedState(this.data);
}

class GetStatesErrorState extends CountryState {
  final String error;
  const GetStatesErrorState(this.error);
}

// GetCities states

class GetCitiesLoadingState extends CountryState {}

class GetCitiesLoadedState extends CountryState {
  final List<dynamic> data;
  const GetCitiesLoadedState(this.data);
}

class GetCitiesErrorState extends CountryState {
  final String error;
  const GetCitiesErrorState(this.error);
}
