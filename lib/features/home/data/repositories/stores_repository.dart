import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/stores_interface.dart';
import '../datasources/stores_data_provider.dart';

class StoresRepository implements StoresInterface {
  final StoresDataProvider storesDataProvider;
  const StoresRepository(this.storesDataProvider);

  @override
  Future<AppResponse> getStores(query) {
    return storesDataProvider.getStores(query);
  }
}
