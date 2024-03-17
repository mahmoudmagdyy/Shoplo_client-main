import '../../../../core/core_model/app_response.dart';

abstract class OrdersInterface {
  Future<AppResponse> getOrders(Map<String, dynamic> query);
  Future<AppResponse> getOrderDetails(id);
  Future<AppResponse> changeOrderStatus(id, query);
  Future<AppResponse> addOrder(data);
  Future<AppResponse> previewOrder(data);
  Future<AppResponse> upload(data);
  Future<AppResponse> sendRate(data);
  Future<AppResponse> acceptRejectScheduled(id, query);
}
