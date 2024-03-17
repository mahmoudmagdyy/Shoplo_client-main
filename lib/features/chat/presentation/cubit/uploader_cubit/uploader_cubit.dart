import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/services/navigation_service.dart';
import '../../../data/data_sources/uploader_data_provider.dart';
import '../../../data/models/uploader.dart';
import '../../../data/repositories/uploader_repository.dart';

part 'uploader_state.dart';

class UploaderCubit extends Cubit<UploaderState> {
  UploaderCubit() : super(UploaderInitial());

  static UploaderCubit get(context) => BlocProvider.of(context);
  static final dataProvider = UploaderDataProvider();
  static final UploaderRepository repository = UploaderRepository(dataProvider);

  ///upload
  void upload(data) {
    debugPrint('data ==>${data.toString()}');

    emit(UploadLoadingState());

    repository.upload(data).then(
      (value) {
        debugPrint('value upload==>${value.toString()}');
        if (value.statusCode == 500) {
          emit(
            UploadErrorState(AppLocalizations.of(
                    NavigationService.navigatorKey.currentContext!)!
                .error_try_again),
          );
        } else if (value.errorMessages != null) {
          emit(UploadErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UploadErrorState(value.errors!));
        } else {
          debugPrint('value upload 22==>${value.toString()}');
          emit(UploadSuccessState(value.data));
        }
      },
    );
  }

  List<UploaderModel> multipleImages = [];
  void multipleUploader(data) {
    debugPrint('data ==>${data.toString()}');

    emit(UploadMultiLoadingState());

    repository.multipleUploader(data).then(
      (value) {
        debugPrint('value upload==>${value.toString()}');
        if (value.errorMessages != null) {
          emit(UploadMultiErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UploadMultiErrorState(value.errors!));
        } else {
          multipleImages = [];
          value.data.forEach((item) {
            multipleImages.add(UploaderModel.fromJson(item));
          });
          emit(UploadMultiSuccessState(multipleImages));
        }
      },
    );
  }
}
