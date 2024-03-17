import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../../my_orders/data/models/order.dart';
import '../../../my_orders/data/repositories/orders_repository.dart';
import '../../data/models/preview_order.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit() : super(AddOrderInitial());

  static AddOrderCubit get(context) => BlocProvider.of(context);
  final repository = serviceLocator.get<OrdersRepository>();

  final Map<String, String> query = {};

  void setOrderData(Map<String, String> data) {
    query.addAll(data);
    emit(SetOrderDataState());
  }

  ///add order
  void addOrder(data) {
    debugPrint('data #####== a ==>${data.toString()}');

    emit(AddOrderLoadingState());

    repository.addOrder(data).then(
      (value) {
        debugPrint('value #####== add order==>${value.toString()}');
        if (value.errorMessages != null) {
          emit(AddOrderErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(AddOrderErrorState(value.errors!));
        } else {
          emit(
            AddOrderSuccessState(
              OrderModel.fromJson(value.data['order']),
              value.data['message'],
            ),
          );
        }
      },
    );
  }

  /// preview order
  void previewOrder(data) {
    debugPrint('data ==>${data.toString()}');

    emit(PreviewOrderLoadingState());

    repository.previewOrder(data).then(
      (value) {
        debugPrint('value add order==>${value.toString()}');
        if (value.errorMessages != null) {
          emit(PreviewOrderErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(PreviewOrderErrorState(value.errors!));
        } else {
          emit(
              PreviewOrderSuccessState(PreviewOrderModal.fromJson(value.data)));
        }
      },
    );
  }
}
