import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/data_sources/profile_data_provider.dart';
import '../../../data/repositories/profile_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  static ChangePasswordCubit get(context) => BlocProvider.of(context);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  ///ChangePassword
  void changePassword(values,accessToken) async{
    String? token = await messaging.getToken();
    values['device_token'] = token;
    emit(ChangePasswordLoadingState());
    final dataProvider = ProfileProvider();
    final ProfileRepository repository = ProfileRepository(dataProvider);
    repository.changePassword(values,accessToken).then(
          (value) {
        debugPrint("🚀 ChangePassword cubit  ${value.toString()}");
        if (value.errorMessages != null) {
          emit(ChangePasswordErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(ChangePasswordErrorState(value.errors!));
        } else {
          emit(ChangePasswordLoadedState(value.data));
        }
      },
    );
  }
}
