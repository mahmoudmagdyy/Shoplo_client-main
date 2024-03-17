import 'package:dartz/dartz.dart';

import '../../../../core/core_model/app_error.dart';
import '../../../../core/core_model/app_response.dart';

abstract class AppPagesInterface {
  Future<Either<AppError,AppResponse>> getPageData(String url);
  Future<AppResponse> getAppSettings();
  Future<AppResponse> getFaq(Map<String, dynamic> query);
}
