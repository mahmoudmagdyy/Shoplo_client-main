import '../../../../core/core_model/app_response.dart';

abstract class CategoriesInterface {
  Future<AppResponse> getCategories(Map<String, dynamic> query);
}
