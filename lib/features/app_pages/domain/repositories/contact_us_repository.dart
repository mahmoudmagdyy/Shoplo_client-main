
import 'package:dartz/dartz.dart';

import '../../../../core/core_model/app_error.dart';
import '../../../../core/core_model/app_response.dart';
import '../../data/data_sources/contact_us_data_provider.dart';
import '../../data/repositories/contact_us_interface.dart';

class ContactUsRepository implements ContactUsInterface {
  final ContactUsDataProvider contactUsDataProvider;
  const ContactUsRepository(this.contactUsDataProvider);
  @override
  Future<AppResponse> sendContactUs(values) {
    return contactUsDataProvider.sendContactUs(values);
  }

  @override
  Future<Either<AppError,AppResponse>> getContactUsTypes() {
    return contactUsDataProvider.getContactUsTypes();
  }

  // @override
  // Future<AppResponse> getContactTypes() {
  //   return contactUsDataProvider.getContactTypes();
  // }
}
