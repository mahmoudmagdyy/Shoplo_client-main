import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../data/models/payment.dart';
import '../../data/repositories/payment_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);
  final repository = serviceLocator.get<PaymentRepository>();
  List<PaymentModel> paymentMethods = [];

  /// GetPayment
  void getPaymentMethods() {
    emit(GetPaymentLoadingState());

    repository.getPaymentMethods().then(
      (value) {
        debugPrint('value==>${value.toString()}');
        if (value.errorMessages != null) {
          emit(GetPaymentMethodsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetPaymentMethodsErrorState(value.errors!));
        } else {
          paymentMethods.clear();
          value.data.forEach((item) {
            paymentMethods.add(PaymentModel.fromJson(item));
          });
          emit(GetPaymentMethodsSuccessState(paymentMethods));
        }
      },
    );
  }

  /// CheckCoupon
  void checkCoupon(data) {
    emit(CheckCouponLoadingState());

    repository.checkCoupon(data).then(
      (value) {
        debugPrint('value==>${value.toString()}');
        if (value.errorMessages != null) {
          emit(CheckCouponErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(CheckCouponErrorState(value.errors!));
        } else {
          emit(CheckCouponSuccessState(value.data));
        }
      },
    );
  }
}
