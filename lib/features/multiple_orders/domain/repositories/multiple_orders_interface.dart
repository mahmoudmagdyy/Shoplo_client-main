import 'package:shoplo_client/core/core_model/app_response.dart';

abstract class MultipleOrdersInterface {
  Future<AppResponse> previewOrder(Map<String, dynamic> query);
}
