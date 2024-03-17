import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/orders_data_provider.dart';
import '../../../data/models/order.dart';
import '../../../data/repositories/orders_repository.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());
  static final OrdersDataProvider dataProvider = OrdersDataProvider();
  static final OrdersRepository repository = OrdersRepository(dataProvider);

  void getOrderDetails(id) async {
    emit(GetOrderDetailsLoadingState());
    repository.getOrderDetails(id).then(
      (value) {
        if (value.errorMessages != null) {
          emit(GetOrderDetailsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetOrderDetailsErrorState(value.errors!));
        } else {
          emit(GetOrderDetailsSuccessState(OrderModel.fromJson(value.data)));
        }
      },
    );
  }
}
