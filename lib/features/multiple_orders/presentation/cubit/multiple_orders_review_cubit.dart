import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/core/services/injection.dart';
import 'package:shoplo_client/features/multiple_orders/domain/request/create_mutiple_order_request.dart';
import 'package:shoplo_client/features/my_orders/data/models/order.dart';

import '../../data/repositories/multiple_orders_review_repository.dart';

part 'multiple_orders_review_state.dart';

class MultipleOrdersReviewCubit extends Cubit<MultipleOrdersReviewState> {
  MultipleOrdersReviewCubit() : super(MultipleOrdersReviewInitial());

  static MultipleOrdersReviewCubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<MultipleOrdersReviewRepository>();

  createOrder(CreateMultipleOrderRequest createRequest) async {
    emit(MultipleOrdersReviewLoading());
    final result = await repository.createOrder({
      ...createRequest.toJson(),
      "use_wallet": 0,
      "payment_method_id": 1,
      "order_price": createRequest.total?.subtotal
    });
    if (result.errorMessages != null) {
      emit(MultipleOrdersReviewError(result.errorMessages!));
    } else if (result.errors != null) {
      emit(MultipleOrdersReviewError(result.errors!));
    } else {
      emit(
        MultipleOrdersReviewSuccess(
          OrderModel.fromJson(result.data['order']),
          result.data['message'],
        ),
      );
    }
  }
}
