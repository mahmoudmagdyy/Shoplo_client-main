import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/cities_interface.dart';
import '../data_sources/cities_data_provider.dart';

class CitiesRepository implements CitiesInterface {
  final CitiesDataProvider citiesDataProvider;
  const CitiesRepository(this.citiesDataProvider);

  @override
  Future<AppResponse> getCities(String countryId) {
    return citiesDataProvider.getCities(countryId);
  }
}
