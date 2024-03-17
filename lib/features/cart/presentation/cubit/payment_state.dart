part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

/// Get Payment Methods
class GetPaymentLoadingState extends PaymentState {}

class GetPaymentMethodsSuccessState extends PaymentState {
  final List<PaymentModel> paymentMethods;
  const GetPaymentMethodsSuccessState(this.paymentMethods);
}

class GetPaymentMethodsErrorState extends PaymentState {
  final String error;
  const GetPaymentMethodsErrorState(this.error);
}

//CheckCouponLoadingState

class CheckCouponLoadingState extends PaymentState {}

class CheckCouponSuccessState extends PaymentState {
  final Map<String, dynamic> data;
  const CheckCouponSuccessState(this.data);
}

class CheckCouponErrorState extends PaymentState {
  final String error;
  const CheckCouponErrorState(this.error);
}
