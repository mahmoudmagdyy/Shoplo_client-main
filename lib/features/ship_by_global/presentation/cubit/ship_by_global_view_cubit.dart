import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../../my_orders/data/models/order.dart';
import '../../data/repositories/ship_by_global_repository.dart';

part 'ship_by_global_view_state.dart';

class ShipByGlobalViewCubit extends Cubit<ShipByGlobalViewState> {
  ShipByGlobalViewCubit() : super(ShipByGlobalViewInitial());

  static ShipByGlobalViewCubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<ShipByGlobalRepository>();

  Future shipByGlobalView(int id) async {
    emit(ShipByGlobalViewLoadingState());
    final result = await repository.getShippingOrder({
      "id": id,
    });
    if (result.errorMessages != null) {
      emit(ShipByGlobalViewErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(ShipByGlobalViewErrorState(result.errors!));
    } else {
      log(result.data.toString());
      emit(ShipByGlobalViewSuccessState(OrderModel.fromJson(result.data!)));
    }
  }

  Future changeShippingStatus(int id, Map<String, dynamic> values) async {
    emit(ShipByGlobalViewChangeStatusLoadingState());
    final result = await repository.changeShippingStatus(id, values);
    if (result.errorMessages != null) {
      emit(ShipByGlobalViewChangeStatusErrorState(result.errorMessages!));
    } else if (result.errors != null) {
      emit(ShipByGlobalViewChangeStatusErrorState(result.errors!));
    } else {
      emit(const ShipByGlobalViewChangeStatusSuccessState("success"));
    }
  }
}
