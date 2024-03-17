import '../../../../core/core_model/app_response.dart';
import '../data_sources/countries_data_provider.dart';
import '../../domain/repositories/countries_interface.dart';


class CountriesRepository implements CountriesInterface {
  final CountriesDataProvider countriesDataProvider;
  const CountriesRepository(this.countriesDataProvider);

  @override
  Future<AppResponse> getCountries(bool all) {
    return countriesDataProvider.getCountries(all);
  }

}
