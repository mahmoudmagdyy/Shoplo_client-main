import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../addresses/domain/entities/country.dart';
import '../../../data/data_sources/countries_data_provider.dart';
import '../../../data/repositories/countries_repository.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());

  static final dataProvider = CountriesDataProvider();
  static final CountriesRepository repository =
      CountriesRepository(dataProvider);

  List<Country> allCountries = [];
  List<Country> viewedCountries = [];
  String selectedCategory = '';

  String flag = "";

  void getFilteredCountries(String val) {
    if (val.isNotEmpty) {
      final suggestions = allCountries.where((country) {
        if (!val.contains(RegExp("[\u0621-\u064A]+"))) {
          final countryLowerCase = country.name.toLowerCase();
          final valLowerCase = val.toLowerCase();
          return countryLowerCase.startsWith(valLowerCase);
        } else {
          return country.name.startsWith(val);
        }
      }).toList();
      viewedCountries = suggestions;
      for (var element in viewedCountries) {
        debugPrint(element.id.toString());
      }
      emit(GetCountriesLoadedState(viewedCountries));
    } else {
      viewedCountries = allCountries;
      emit(GetCountriesLoadedState(viewedCountries));
    }
  }

  //getCountries
  void getCountries({String countryCode = '-1', bool all = false}) {
    emit(GetCountriesLoadingState());
    repository.getCountries(all).then(
      (value) {
        allCountries = [];
        if (value.errorMessages != null) {
          emit(GetCountriesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetCountriesErrorState(value.errors!));
        } else {
          // debugPrint('value.data: ${value.data}', wrapWidth: 1024);
          if (value.data.length > 0) {
            value.data.forEach((item) {
              allCountries.add(Country.fromJson(item));
            });
          }
          viewedCountries = allCountries;
          // countries.addAll(value.data);
          if (countryCode != '-1') {
            final selectedIndex = allCountries
                .firstWhere((element) => element.phoneCode == countryCode);
            debugPrint('SELECTEDINDEX: ${selectedIndex.flag}', wrapWidth: 1024);
            flag = selectedIndex.flag;
          }
          debugPrint('COUNTRIES length222: ${allCountries.length}',
              wrapWidth: 1024);
          emit(GetCountriesLoadedState(viewedCountries));
        }
      },
    );
  }
}
