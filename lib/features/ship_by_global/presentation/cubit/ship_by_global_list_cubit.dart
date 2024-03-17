import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../../my_orders/data/models/order.dart';
import '../../data/repositories/ship_by_global_repository.dart';

part 'ship_by_global_list_state.dart';

class ShipByGlobalListCubit extends Cubit<ShipByGlobalListState> {
  ShipByGlobalListCubit() : super(ShipByGlobalListInitial());

  static ShipByGlobalListCubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<ShipByGlobalRepository>();

  final List<OrderModel> orders = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

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

      emit(ShipByGlobalListLoadingState());
    } else {
      loadingMoreResults = true;
      emit(ShipByGlobalListLoadingNextPageState());
    }
    repository.getShippingOrders(query).then(
      (value) {
        loadingMoreResults = false;
        if (value.errorMessages != null) {
          emit(ShipByGlobalListErrorState(value.errorMessages!));
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

          emit(ShipByGlobalListSuccessState(orders));
        }
      },
    );
  }
}
