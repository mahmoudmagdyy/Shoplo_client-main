import 'package:shoplo_client/core/core_model/app_response.dart';
import '../../domain/repositories/multiple_orders_interface.dart';
import '../datasources/multiple_orders_data_provider.dart';

class MultipleOrdersRepository implements MultipleOrdersInterface {
  final MultipleOrdersDataProvider multipleOrdersDataProvider;
  MultipleOrdersRepository(this.multipleOrdersDataProvider);

  @override
  Future<AppResponse> previewOrder(Map<String, dynamic> query) {
    return multipleOrdersDataProvider.previewOrder(query);
  }
}
