import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/products_interface.dart';
import '../datasources/products_data_provider.dart';

class ProductsRepository implements ProductsInterface {
  final ProductsDataProvider productsDataProvider;
  const ProductsRepository(this.productsDataProvider);

  @override
  Future<AppResponse> getStoresProducts(query) {
    return productsDataProvider.getStoresProducts(query);
  }

  @override
  Future<AppResponse> getProductDetails(id) {
    return productsDataProvider.getProductDetails(id);
  }
}
