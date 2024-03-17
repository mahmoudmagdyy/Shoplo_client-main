import 'package:dartz/dartz.dart';

import '../../../../core/core_model/app_error.dart';
import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/app_pages_interface.dart';
import '../data_sources/app_pages_data_provider.dart';

class AppPagesRepository implements AppPagesInterface {
  final AppPagesDataProvider appPagesDataProvider;
  const AppPagesRepository(this.appPagesDataProvider);
  @override
  Future<Either<AppError,AppResponse>> getPageData(url) {
    return appPagesDataProvider.getPageData(url);
  }

  @override
  Future<AppResponse> getAppSettings() {
    return appPagesDataProvider.getAppSettings();
  }

  @override
  Future<AppResponse> getFaq(Map<String, dynamic> query) {
    return appPagesDataProvider.getFaq(query);
  }
}
