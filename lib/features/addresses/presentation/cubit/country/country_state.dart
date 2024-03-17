part of 'country_cubit.dart';

@immutable
abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountriesState {}

class CountriesLoadingStateNew extends CountriesState {}


class CountriesErrorStateNew extends CountriesState {
  final String error;
  const CountriesErrorStateNew(this.error);
}

class CountriesSuccessStateNew extends CountriesState {
  final List<Country> categories;
  const CountriesSuccessStateNew(this.categories);
}

class ResetCountriesCubit extends CountriesState {}