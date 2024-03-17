part of 'city_cubit.dart';

@immutable
abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

///get citises
class CitiesLoadingStateNew extends CityState {}


class CitiesErrorStateNew extends CityState {
  final String error;
  const CitiesErrorStateNew(this.error);
}

class CitiesSuccessStateNew extends CityState {
  final List<City> cities;
  const CitiesSuccessStateNew(this.cities);
}

class ResetCitiesCubit extends CityState {}