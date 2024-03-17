import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../data/datasources/stores_data_provider.dart';
import '../../data/models/place_details.dart';
import '../../data/repositories/stores_repository.dart';

part 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  StoresCubit() : super(StoresInitial());
  static final dataProvider = StoresDataProvider();
  static final StoresRepository repository = StoresRepository(dataProvider);

  int totalCount = 0;
  final List<PlaceDetails> stores = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  void getStores(Map<String, dynamic> queryData, {String? url}) async {
    debugPrint('QUERYDATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      debugPrint('object 1 ');
      stores.clear();
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (query['page'] == 1) {
      stores.clear();
      emit(GetStoresLoadingState());
    } else {
      loadingMoreResults = true;
      emit(GetStoresLoadingNextPageState());
    }
    repository.getStores(query).then(
      (value) {
        loadingMoreResults = false;

        if (value.errorMessages != null) {
          emit(GetStoresErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetStoresErrorState(value.errors!));
        } else {
          endLoadingFirstTime = true;
          List<PlaceDetails> ordersList = [];
          value.data.forEach((item) {
            ordersList.add(PlaceDetails.fromJson(item));
          });

          debugPrint('_orders ${ordersList.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            stores.addAll(ordersList);
          } else {
            stores.clear();
            stores.addAll(ordersList);
          }
          if (stores.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (stores.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          debugPrint('orders ${stores.length}');
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(GetStoresSuccessState(stores));
        }
      },
    );
  }
}
