import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/features/my_orders/presentation/cubit/scheduled_order_state.dart';

import '../../data/datasources/orders_data_provider.dart';
import '../../data/repositories/orders_repository.dart';

class ScheduledOrderCubit extends Cubit<ScheduledOrderState> {
  ScheduledOrderCubit() : super(ScheduledOrderInitial());

  static ScheduledOrderCubit get(context) => BlocProvider.of(context);

  static final OrdersDataProvider dataProvider = OrdersDataProvider();
  static final OrdersRepository repository = OrdersRepository(dataProvider);

//acceptRejectScheduled
  void acceptRejectScheduled(id, query) async {
    emit(AcceptRejectScheduledLoadingState());
    repository.acceptRejectScheduled(id, query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(AcceptRejectScheduledErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(AcceptRejectScheduledErrorState(value.errors!));
        } else {
          emit(AcceptRejectScheduledSuccessState(query['status']));
        }
      },
    );
  }
}
