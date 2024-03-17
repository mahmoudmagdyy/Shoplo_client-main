import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/orders_data_provider.dart';
import '../../data/models/order.dart';
import '../../data/repositories/orders_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of(context);

  static final OrdersDataProvider dataProvider = OrdersDataProvider();
  static final OrdersRepository repository = OrdersRepository(dataProvider);

  final List<OrderModel> orders = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  final List<OrderModel> ordersFinished = [];
  bool hasReachedEndOfResultsFinished = false;
  bool endLoadingFirstTimeFinished = false;
  bool loadingMoreResultsFinished = false;
  Map<String, dynamic> queryFinished = {
    'page': 1,
    'per_page': 10,
  };

  final List<OrderModel> ordersRejected = [];
  bool hasReachedEndOfResultsRejected = false;
  bool endLoadingFirstTimeRejected = false;
  bool loadingMoreResultsRejected = false;
  Map<String, dynamic> queryRejected = {
    'page': 1,
    'per_page': 10,
  };

  bool refreshOrderDetails = false;

  /// get orders
  void getOrders(Map<String, dynamic> queryData) async {
    debugPrint('QUERY DATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (!endLoadingFirstTime) {
      orders.clear();
    }
    debugPrint('QUERY: $query', wrapWidth: 1024);

    if (query['page'] == 1) {
      // query.addAll({
      //   'is_read': 1,
      // });

      emit(OrdersLoadingState());
    } else {
      loadingMoreResults = true;
      emit(OrdersLoadingNextPageState());
    }
    repository.getOrders(query).then(
      (value) {
        loadingMoreResults = false;
        if (value.errorMessages != null) {
          emit(OrdersErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTime = true;
          List<OrderModel> ordersList = [];
          value.data.forEach((item) {
            ordersList.add(OrderModel.fromJson(item));
          });

          debugPrint('_orders ${ordersList.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            orders.addAll(ordersList);
          } else {
            orders.clear();
            orders.addAll(ordersList);
          }
          if (orders.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (orders.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          debugPrint('orders ${orders.length}');
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(OrdersSuccessState(orders));
        }
      },
    );
  }

  void getFinishedOrders(Map<String, dynamic> queryData) async {
    debugPrint('QUERY DATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      queryFinished.clear();
      queryFinished['page'] = 1;
      queryFinished['per_page'] = 10;
      queryFinished.addAll(queryData);
    }
    if (!endLoadingFirstTimeFinished) {
      ordersFinished.clear();
    }
    debugPrint('QUERY: $queryFinished', wrapWidth: 1024);

    if (queryFinished['page'] == 1) {
      // query.addAll({
      //   'is_read': 1,
      // });

      emit(FinishedOrdersLoadingState());
    } else {
      loadingMoreResultsFinished = true;
      emit(FinishedOrdersLoadingNextPageState());
    }
    repository.getOrders(queryFinished).then(
      (value) {
        loadingMoreResultsFinished = false;
        if (value.errorMessages != null) {
          emit(FinishedOrdersErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTimeFinished = true;
          List<OrderModel> ordersList = [];
          value.data.forEach((item) {
            ordersList.add(OrderModel.fromJson(item));
          });

          debugPrint('_orders ${ordersList.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            ordersFinished.addAll(ordersList);
          } else {
            ordersFinished.clear();
            ordersFinished.addAll(ordersList);
          }
          if (ordersFinished.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResultsFinished = true;
          } else if (ordersFinished.length < value.meta['total']) {
            hasReachedEndOfResultsFinished = false;
          }
          debugPrint('orders ${ordersFinished.length}');
          if (queryFinished['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            queryFinished['page'] += 1;
          } else {
            queryFinished['page'] = 1;
          }

          emit(FinishedOrdersSuccessState(ordersFinished));
        }
      },
    );
  }

  void getRejectedOrders(Map<String, dynamic> queryData) async {
    debugPrint('QUERY DATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      queryRejected.clear();
      queryRejected['page'] = 1;
      queryRejected['per_page'] = 10;
      queryRejected.addAll(queryData);
    }
    if (!endLoadingFirstTimeRejected) {
      ordersRejected.clear();
    }
    debugPrint('QUERY: $queryRejected', wrapWidth: 1024);

    if (queryRejected['page'] == 1) {
      // query.addAll({
      //   'is_read': 1,
      // });

      emit(RejectedOrdersLoadingState());
    } else {
      loadingMoreResultsRejected = true;
      emit(RejectedOrdersLoadingNextPageState());
    }
    repository.getOrders(queryRejected).then(
      (value) {
        loadingMoreResultsRejected = false;
        if (value.errorMessages != null) {
          emit(OrdersErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTimeRejected = true;
          List<OrderModel> ordersList = [];
          value.data.forEach((item) {
            ordersList.add(OrderModel.fromJson(item));
          });

          debugPrint('_orders ${ordersList.length}');
          if (queryRejected['page'] != 1) {
            debugPrint('----- lode more ');
            ordersRejected.addAll(ordersList);
          } else {
            ordersRejected.clear();
            ordersRejected.addAll(ordersList);
          }
          if (ordersRejected.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResultsRejected = true;
          } else if (ordersRejected.length < value.meta['total']) {
            hasReachedEndOfResultsRejected = false;
          }
          debugPrint('orders ${ordersRejected.length}');
          if (queryRejected['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            queryRejected['page'] += 1;
          } else {
            queryRejected['page'] = 1;
          }

          emit(RejectedOrdersSuccessState(ordersRejected));
        }
      },
    );
  }

  void changeOrderStatus(id, query) async {
    emit(ChangeOrderStatusLoadingState());
    repository.changeOrderStatus(id, query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(ChangeOrderStatusErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ChangeOrderStatusErrorState(value.errors!));
        } else {
          refreshOrderDetails = !refreshOrderDetails;

          // if (query["status"] == "delivery_done") {
          //   debugPrint('refreshOrderDetails xxx: $refreshOrderDetails',
          //       wrapWidth: 1024);
          //   orders.removeWhere((element) => element.id == value.data['id']);
          //   ordersFinished
          //       .addAll([OrderModel.fromJson(value.data), ...ordersFinished]);
          // }
          debugPrint("changeOrderStatus delete order ${value.data} ");
          emit(const ChangeOrderStatusSuccessState());
        }
      },
    );
  }
}
