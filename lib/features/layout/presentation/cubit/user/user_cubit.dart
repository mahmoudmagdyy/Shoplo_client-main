import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/data/models/user_data.dart';
import '../../../domain/repositories/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  // User Data
  UserDataModel? userData = UserRepository.initUserData();

  void setUser(UserDataModel? currentUserData) {
    userData = currentUserData;
    emit(SetUserData());
  }

  void setUserLocation(Map location) {
    UserRepository.changeCurrency({"country_id": location['country_id']});
    emit(SetUserLocation(location));
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //location
  String lat = '';
  String lng = '';
  void setUserLatLong(String lat, String lng) {
    emit(SetUserLatLong());
    debugPrint('LAT: $lat}', wrapWidth: 1024);
    lat = lat;
    lng = lng;
    // emit(UserLatLong());
  }
}
