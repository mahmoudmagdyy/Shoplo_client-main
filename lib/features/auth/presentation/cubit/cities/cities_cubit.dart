import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/features/auth/data/models/cities_search.dart';

import '../../../../../core/helpers/storage_helper.dart';
import '../../../data/data_sources/cities_data_provider.dart';
import '../../../data/repositories/cities_repository.dart';
import 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(CitiesInitial());

  static final dataProvider = CitiesDataProvider();
  static final CitiesRepository repository = CitiesRepository(dataProvider);

  String selectedCategory = '';
  bool refreshHome = false;
  late CitiesSearch allCities;

  void setSelectedCategory(String category) {
    emit(SetSelectedCategoryState());
    debugPrint("🚀 ~ ~ SELECTED CATEGORY~ ~ $category");
    StorageHelper.saveData(
      key: "selectedCategory",
      value: category,
    );
    selectedCategory = category;
    refreshHome = !refreshHome;
    debugPrint('refreshHome xxx: $refreshHome', wrapWidth: 1024);
    emit(SetSelectedCategoryState1());
  }

  Future<void> getCities(String countryId) async {
    emit(GetCitiesLoadingState());
    repository.getCities(countryId).then(
      (value) {
        if (value.errorMessages != null) {
          emit(GetCitiesErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetCitiesErrorState(value.errors!));
        } else if (value.data.isEmpty) {
          emit(GetCitiesEmpty());
        } else {
          // debugPrint('value.data: ${value.data}', wrapWidth: 1024);
          allCities = CitiesSearch.fromJson(value.data);
          emit(GetCitiesLoadedState(CitiesSearch.fromJson(value.data)));
        }
      },
    );
  }

  void getFilteredCities(String val, CitiesSearch cities) {
    if (val.isNotEmpty) {
      final suggestions = allCities.cities.where((city) {
        if (!val.contains(RegExp("[\u0621-\u064A]+"))) {
          final countryLowerCase = city.name.toLowerCase();
          final valLowerCase = val.toLowerCase();
          return countryLowerCase.startsWith(valLowerCase);
        } else {
          return city.name.startsWith(val);
        }
      }).toList();
      emit(GetCitiesLoadedState(cities.copyWith(cities: suggestions)));
    } else {
      emit(GetCitiesLoadedState(allCities));
    }
  }
}
