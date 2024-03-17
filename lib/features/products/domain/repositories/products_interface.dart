import '../../../../core/core_model/app_response.dart';

abstract class ProductsInterface {
  Future<AppResponse> getStoresProducts(query);
  Future<AppResponse> getProductDetails(id);
}
