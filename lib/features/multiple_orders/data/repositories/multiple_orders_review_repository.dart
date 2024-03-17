import 'package:shoplo_client/core/core_model/app_response.dart';
import '../../domain/repositories/multiple_orders_review_interface.dart';
import '../datasources/multiple_orders_review_data_provider.dart';

class MultipleOrdersReviewRepository implements MultipleOrdersReviewInterface {
  final MultipleOrdersReviewDataProvider multipleOrdersReviewDataProvider;
  MultipleOrdersReviewRepository(this.multipleOrdersReviewDataProvider);

  @override
  Future<AppResponse> createOrder(query) {
    return multipleOrdersReviewDataProvider.createOrder(query);
  }
}
