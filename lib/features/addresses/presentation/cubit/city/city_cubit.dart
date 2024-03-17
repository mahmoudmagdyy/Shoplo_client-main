import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/method_helper.dart';
import '../../../data/data_source/address_data_provider.dart';
import '../../../data/repositories/address_repository.dart';
import '../../../domain/entities/city.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityInitial());

  static CityCubit get(context) => BlocProvider.of(context);

  static final addressProvider = AddressProvider();
  static final AddressRepository dropDownDataRepository =
  AddressRepository(addressProvider);

  ///getciticies
  City? citiesModel;
  void setSelectedCitesModel(City? type) {
    citiesModel = type;
  }

  List<City> cites = [];
  void getCites(id, {query}) {
    emit(CitiesLoadingStateNew());
    dropDownDataRepository.getCities(id, query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(CitiesErrorStateNew(value.errorMessages!));
        } else if (value.errors != null) {
          emit(CitiesErrorStateNew(value.errors!));
        } else {
          cites = [];
          citiesModel = null;
          debugPrint('VALUE xxxxx xxx: ${value.data}', wrapWidth: 1024);
          value.data.forEach((item) {
            cites.add(City.fromJson(item));
          });
          emit(CitiesSuccessStateNew(cites));
        }
      },
    );
  }

  void setCityModel(int stateId) {
    citiesModel = (cites.isNotEmpty)
        ? cites[getIndex(cites, stateId)]
        : null;
  }

  void resetCubit() {
    //cities
    cites = [];
    citiesModel = null;
    emit(ResetCitiesCubit());
  }
}
