import '../../../../core/core_model/app_response.dart';

abstract class UploaderInterface {
  Future<AppResponse> upload(data);
  Future<AppResponse> multipleUploader(data);
}
