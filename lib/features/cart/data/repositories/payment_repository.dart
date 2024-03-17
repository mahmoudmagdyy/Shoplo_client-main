import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/payment_interface.dart';
import '../datasources/payment_data_provider.dart';

class PaymentRepository implements PaymentInterface {
  final PaymentDataProvider paymentDataProvider;
  const PaymentRepository(this.paymentDataProvider);

  @override
  Future<AppResponse> getPaymentMethods() {
    return paymentDataProvider.getPaymentMethods();
  }

  @override
  Future<AppResponse> getOnlineMethods() {
    return paymentDataProvider.getOnlineMethods();
  }

  @override
  Future<AppResponse> getBanks() {
    return paymentDataProvider.getBanks();
  }

  @override
  Future<AppResponse> checkCoupon(data) {
    return paymentDataProvider.checkCoupon(data);
  }
}
