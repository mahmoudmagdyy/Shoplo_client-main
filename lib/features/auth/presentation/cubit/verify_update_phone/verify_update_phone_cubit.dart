import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/data_sources/auth_data_provider.dart';
import '../../../data/models/user_data.dart';
import '../../../data/repositories/auth_repository.dart';
part 'verify_update_phone_state.dart';

class VerifyUpdatePhoneCubit extends Cubit<VerifyUpdatePhoneState> {
  VerifyUpdatePhoneCubit() : super(VerifyUpdatePhoneInitial());

  static VerifyUpdatePhoneCubit get(context) => BlocProvider.of(context);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //Verify
  void verifyCode(values) async {
    String? token = await messaging.getToken();
    values['device_token'] = token;
    emit(VerifyUpdatePhoneLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.verifyUpdatePhone(values).then(
          (value) {
        if (value.errorMessages != null) {
          emit(VerifyUpdatePhoneErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(VerifyUpdatePhoneErrorState(value.errors!));
        } else {
          if (value.data["user"] != null) {
            debugPrint("@@@@@!1${value.data}");
            emit(VerifyUpdatePhoneUserLoadedState(UserDataModel.fromJson(value.data)));
            debugPrint("@@@@@!2");
          } else {
            emit(VerifyUpdatePhoneLoadedState(value.data));
          }
        }
      },
    );
  }

  ///Resend
  void resendCode(values) {
    emit(ResendUpdatePhoneLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.resendCode(values).then(
          (value) {
        if (value.errorMessages != null) {
          emit(ResendUpdatePhoneErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ResendUpdatePhoneErrorState(value.errors!));
        } else {
          emit(ResendUpdatePhoneLoadedState(value.data));
        }
      },
    );
  }
}
