import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/orders_interface.dart';
import '../datasources/orders_data_provider.dart';

class OrdersRepository implements OrdersInterface {
  final OrdersDataProvider ordersDataProvider;
  const OrdersRepository(this.ordersDataProvider);

  @override
  Future<AppResponse> getOrders(query) {
    return ordersDataProvider.getOrders(query);
  }

  @override
  Future<AppResponse> getOrderDetails(id) {
    return ordersDataProvider.getOrderDetails(id);
  }

  @override
  Future<AppResponse> changeOrderStatus(id, query) {
    return ordersDataProvider.changeOrderStatus(id, query);
  }

  @override
  Future<AppResponse> addOrder(data) {
    return ordersDataProvider.addOrder(data);
  }

  @override
  Future<AppResponse> previewOrder(data) {
    return ordersDataProvider.previewOrder(data);
  }

  @override
  Future<AppResponse> upload(data) {
    return ordersDataProvider.upload(data);
  }

  @override
  Future<AppResponse> sendRate(data) {
    return ordersDataProvider.sendRate(data);
  }

  @override
  Future<AppResponse> acceptRejectScheduled(id, query) {
    return ordersDataProvider.acceptRejectScheduled(id, query);
  }
}
