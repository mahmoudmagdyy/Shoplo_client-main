import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../data/data_sources/auth_data_provider.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/repositories/auth_statics.dart';
part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  static DeleteAccountCubit get(context) => BlocProvider.of(context);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// DeleteAccount
  void deleteAccount() async {
    String? token = await messaging.getToken();
    Map<String, dynamic> values = {
      'device_token': token,
    };
    debugPrint('VALUES DeleteAccount: $values}', wrapWidth: 1024);
    emit(DeleteAccountLoadingState());
    final dataProvider = AuthDataProvider();
    final AuthRepository repository = AuthRepository(dataProvider);
    repository.deleteAccount(values).then(
          (value) {
        debugPrint("🚀🚀🚀🚀🚀🚀 error  ${value.errorMessages}}");
        if (value.errorMessages != null) {
          emit(DeleteAccountErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(DeleteAccountErrorState(value.errors!));
        } else {
          AuthStatics.logout();
          emit(DeleteAccountSuccessState());
        }
      },
    );
  }
}
