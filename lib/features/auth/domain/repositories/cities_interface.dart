import '../../../../core/core_model/app_response.dart';

abstract class CitiesInterface {
  Future<AppResponse> getCities(String countryId);
}
