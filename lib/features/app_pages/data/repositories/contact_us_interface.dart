import 'package:dartz/dartz.dart';

import '../../../../core/core_model/app_error.dart';
import '../../../../core/core_model/app_response.dart';

abstract class ContactUsInterface {
  Future<Either<AppError,AppResponse>> getContactUsTypes();
  Future<AppResponse> sendContactUs(values);
  // Future<AppResponse> getContactTypes();
}
