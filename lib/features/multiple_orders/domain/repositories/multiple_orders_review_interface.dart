import 'package:shoplo_client/core/core_model/app_response.dart';

abstract class MultipleOrdersReviewInterface {
  Future<AppResponse> createOrder(query);
}
