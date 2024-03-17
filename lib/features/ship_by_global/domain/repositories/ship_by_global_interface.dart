import 'package:shoplo_client/core/core_model/app_response.dart';

abstract class ShipByGlobalInterface {
  Future<AppResponse> addShipping(Map<String, dynamic> values);
  Future<AppResponse> getShippingOrders(Map<String, dynamic> values);
  Future<AppResponse> getShippingOrder(Map<String, dynamic> values);

  Future<AppResponse> changeShippingStatus(int id, Map<String, dynamic> values);
  Future<AppResponse> payment(int id, Map<String, dynamic> values);
}
