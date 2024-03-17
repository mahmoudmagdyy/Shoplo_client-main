part of 'uploader_cubit.dart';

abstract class UploaderState extends Equatable {
  const UploaderState();

  @override
  List<Object> get props => [];
}

class UploaderInitial extends UploaderState {}

/// Upload
class UploadLoadingState extends UploaderState {}

class UploadSuccessState extends UploaderState {
  final Map<String, dynamic> data;
  const UploadSuccessState(this.data);
}

// class UploadMultiSuccessState extends UploaderState {
//   final Map<String, dynamic> data;
//   const UploadMultiSuccessState(this.data);
// }

class UploadErrorState extends UploaderState {
  final String error;
  const UploadErrorState(this.error);
}

/// Upload multi
class UploadMultiLoadingState extends UploaderState {}

class UploadMultiSuccessState extends UploaderState {
  final List<UploaderModel> data;
  const UploadMultiSuccessState(this.data);
}

class UploadMultiErrorState extends UploaderState {
  final String error;
  const UploadMultiErrorState(this.error);
}
