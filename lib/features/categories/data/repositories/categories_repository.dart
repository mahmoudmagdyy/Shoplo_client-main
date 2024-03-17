import 'package:shoplo_client/core/core_model/app_response.dart';

import '../../domain/repositories/categories_interface.dart';
import '../datasources/category_data_provider.dart';

class CategoriesRepository implements CategoriesInterface {
  CategoriesRepository(this.categoriesDataSource);
  final CategoriesDataProvider categoriesDataSource;
  @override
  Future<AppResponse> getCategories(Map<String, dynamic> query) {
    return categoriesDataSource.getCategories(query);
  }
}
