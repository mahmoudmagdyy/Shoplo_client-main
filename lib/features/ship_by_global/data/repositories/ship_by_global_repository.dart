import 'package:shoplo_client/core/core_model/app_response.dart';
import '../../domain/repositories/ship_by_global_interface.dart';
import '../datasources/ship_by_global_data_provider.dart';

class ShipByGlobalRepository implements ShipByGlobalInterface {
  final ShipByGlobalDataProvider shipByGlobalDataProvider;
  ShipByGlobalRepository(this.shipByGlobalDataProvider);

  @override
  Future<AppResponse> addShipping(Map<String, dynamic> values) async {
    return await shipByGlobalDataProvider.addShipping(values);
  }

  @override
  Future<AppResponse> getShippingOrders(Map<String, dynamic> values) async {
    return await shipByGlobalDataProvider.getShipping(values);
  }

  @override
  Future<AppResponse> getShippingOrder(Map<String, dynamic> values) async {
    return await shipByGlobalDataProvider.getShippingOrder(values);
  }

  @override
  Future<AppResponse> changeShippingStatus(int id, Map<String, dynamic> values) async {
    return await shipByGlobalDataProvider.changeShippingStatus(id, values);
  }

  @override
  Future<AppResponse> payment(int id, Map<String, dynamic> values) async {
    return await shipByGlobalDataProvider.payment(id, values);
  }
}
