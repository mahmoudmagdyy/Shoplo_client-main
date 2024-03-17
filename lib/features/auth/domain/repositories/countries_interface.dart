import '../../../../core/core_model/app_response.dart';

abstract class CountriesInterface {
  Future<AppResponse> getCountries(bool all);
}
