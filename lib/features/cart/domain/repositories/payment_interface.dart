import '../../../../core/core_model/app_response.dart';

abstract class PaymentInterface {
  Future<AppResponse> getPaymentMethods();
  Future<AppResponse> getOnlineMethods();
  Future<AppResponse> getBanks();
  Future<AppResponse> checkCoupon(data);
}
