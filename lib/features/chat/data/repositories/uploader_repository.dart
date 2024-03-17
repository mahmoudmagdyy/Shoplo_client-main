import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/uploader_interface.dart';
import '../data_sources/uploader_data_provider.dart';

class UploaderRepository implements UploaderInterface {
  final UploaderDataProvider uploaderDataProvider;

  const UploaderRepository(this.uploaderDataProvider);

  @override
  Future<AppResponse> upload(data, {Function(int, int)? onSendProgress}) {
    return uploaderDataProvider.upload(data, onSendProgress: onSendProgress);
  }

  @override
  Future<AppResponse> multipleUploader(data, {dynamic Function(int, int)? onSendProgress}) {
    return uploaderDataProvider.multipleUploader(data, onSendProgress: onSendProgress);
  }
}
