import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/features/addresses/data/data_source/address_data_provider.dart';

import '../../data/models/address_model.dart';
import '../../data/repositories/address_repository.dart';

part 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit() : super(AddressesInitial());
  static AddressesCubit get(context) => BlocProvider.of(context);
  static final dataProvider = AddressProvider();
  static final AddressRepository repository = AddressRepository(dataProvider);
  List<AddressModel> addresses = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  int currentItemId = -1;

  void getAddresses() async {
    emit(GetAddressesLoadingState());
    repository.getMyAddresses().then(
      (value) {
        if (value.errorMessages != null) {
          emit(GetAddressesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetAddressesErrorState(value.errors!));
        } else {
          addresses = [];
          value.data.forEach((item) {
            addresses.add(AddressModel.fromJson(item));
          });
          emit(GetAddressesSuccessState(addresses));
        }
      },
    );
  }

  void getAddressDetails(id) async {
    emit(GetAddressesDetailsLoadingState());
    repository.getAddressesDetails(id).then(
      (value) {
        if (value.errorMessages != null) {
          emit(GetAddressesDetailsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetAddressesDetailsErrorState(value.errors!));
        } else {
          emit(GetAddressesDetailsSuccessState(
              AddressModel.fromJson(value.data)));
        }
      },
    );
  }

  void addAddresses(values) async {
    emit(AddAddressesLoadingState());
    repository.addAddressProfile(values).then(
      (value) {
        if (value.errorMessages != null) {
          emit(AddAddressesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(AddAddressesErrorState(value.errors!));
        } else {
          debugPrint("printAddress ${value.data} ");
          emit(AddAddressesSuccessState(value.data["message"]));
        }
      },
    );
  }

  void editAddresses(values, id) async {
    emit(EditAddressesLoadingState());
    currentItemId = id;
    repository.editAddressProfile(values, id).then(
      (value) {
        if (value.errorMessages != null) {
          emit(EditAddressesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(EditAddressesErrorState(value.errors!));
        } else {
          debugPrint("printAddress ${value.data} ");
          emit(EditAddressesSuccessState(AddressModel.fromJson(value.data)));
        }
      },
    );
  }

  void deleteAddresses(id) async {
    emit(DeleteAddressesLoadingState());
    currentItemId = id;
    repository.deleteAddress(id).then(
      (value) {
        if (value.errorMessages != null) {
          emit(DeleteAddressesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(DeleteAddressesErrorState(value.errors!));
        } else {
          debugPrint("printAddress ${value.data} ");
          emit(DeleteAddressesSuccessState(value.data["message"]));
        }
      },
    );
  }
}
