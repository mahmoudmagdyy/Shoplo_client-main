import 'package:shoplo_client/features/auth/data/data_sources/auth_data_provider.dart';
import 'package:shoplo_client/features/auth/domain/repositories/auth_interface.dart';
import '../../../../core/core_model/app_response.dart';


class AuthRepository implements AuthInterface {
  final AuthDataProvider dataProvider;
  const AuthRepository(this.dataProvider);

  @override
  Future<AppResponse> register(Map<String, dynamic> values) {
    return dataProvider.register(values);
  }

  @override
  Future<AppResponse> login(Map<String, dynamic> values) {
    return dataProvider.login(values);
  }

  @override
  Future<AppResponse> verifyCode(values) {
    return dataProvider.verifyCode(values);
  }

  @override
  Future<AppResponse> resendCode(values) {
    return dataProvider.resendCode(values);
  }

  @override
  Future<AppResponse> verifyUpdatePhone(values) {
    return dataProvider.verifyUpdatePhone(values);
  }

  @override
  Future<AppResponse> logout(Map<String, dynamic> values) {
    return dataProvider.logout(values);
  }

  @override
  Future<AppResponse> forgetPassword(values) {
    return dataProvider.forgetPassword(values);
  }

  @override
  Future<AppResponse> verifyToken(values, accessToken) {
    return dataProvider.verifyToken(values, accessToken);
  }

  @override
  Future<AppResponse> resetPassword(values) {
    return dataProvider.resetPassword(values);
  }
  @override
  Future<AppResponse> deleteAccount(values) {
    return dataProvider.deleteAccount(values);
  }
}
