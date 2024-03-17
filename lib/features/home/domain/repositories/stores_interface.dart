import '../../../../core/core_model/app_response.dart';

abstract class StoresInterface {
  Future<AppResponse> getStores(query);
}
