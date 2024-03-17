import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/method_helper.dart';
import '../../../data/data_source/address_data_provider.dart';
import '../../../data/repositories/address_repository.dart';
import '../../../domain/entities/country.dart';

part 'country_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountryInitial());

  static CountriesCubit get(context) => BlocProvider.of(context);

  static final addressProvider = AddressProvider();
  static final AddressRepository dropDownDataRepository =
  AddressRepository(addressProvider);

  void resetCubit() {
    emit(ResetCountriesCubit());
    countries = [];
    countriesModel = null;
  }

  ///dropDown
  Country? countriesModel;
  void setSelectedCountriesModel(Country type) {
    countriesModel = type;
  }

  List<Country> countries = [];
  void getCountries({query}) {
    emit(CountriesLoadingStateNew());
    dropDownDataRepository.getCountries(query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(CountriesErrorStateNew(value.errorMessages!));
        } else if (value.errors != null) {
          emit(CountriesErrorStateNew(value.errors!));
        } else {
          countries = [];
          debugPrint('VALUE xxxxx xxx: ${value.data}', wrapWidth: 1024);
          value.data.forEach((item) {
            countries.add(Country.fromJson(item));
          });
          emit(CountriesSuccessStateNew(countries));
        }
      },
    );
  }

  void setCountriesModel(int countryId) {
    countriesModel = (countries.isNotEmpty)
        ? countries[getIndex(countries, countryId)]
        : null;
  }
}
