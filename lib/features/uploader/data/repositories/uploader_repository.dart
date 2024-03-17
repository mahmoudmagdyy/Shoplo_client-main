import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/uploader_interface.dart';
import '../data_sources/uploader_data_provider.dart';

class UploaderRepository implements UploaderInterface {
  final UploaderDataProvider uploaderDataProvider;

  const UploaderRepository(this.uploaderDataProvider);

  @override
  Future<AppResponse> upload(data) {
    return uploaderDataProvider.upload(data);
  }

  @override
  Future<AppResponse> multipleUploader(data) {
    return uploaderDataProvider.multipleUploader(data);
  }
}
