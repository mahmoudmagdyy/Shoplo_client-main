import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplo_client/features/home/data/datasources/stores_data_provider.dart';
import 'package:shoplo_client/features/home/data/repositories/stores_repository.dart';

import '../../data/models/place_details.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  static final dataProvider = StoresDataProvider();
  static final StoresRepository repository = StoresRepository(dataProvider);
  int? selectedCategoryId;
  int totalCount = 0;
  final List<PlaceDetails> stores = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  selectCategory(int? id) {
    selectedCategoryId = id;

    emit(SelectCategoryState());
    print('🚀 ~ file: home_cubit.dart ~ line 58 ~ HomeCubit ~ id ~ $id');
  }
}
  // void getStores(Map<String, dynamic> queryData, {String? url}) async {
  //   debugPrint('QUERYDATA: $queryData}', wrapWidth: 1024);
  //   if (queryData.isNotEmpty && queryData['loadMore'] != true) {
  //     debugPrint('object 1 ');
  //     stores.clear();
  //     query.clear();
  //     query['page'] = 1;
  //     query['per_page'] = 10;
  //     query.addAll(queryData);
  //   }
  //   if (query['page'] == 1) {
  //     stores.clear();
  //     emit(GetStoresLoadingState());
  //   } else {
  //     loadingMoreResults = true;
  //     emit(GetStoresLoadingNextPageState());
  //   }
  //   emit(GetStoresSuccessState(stores));
  //   repository.getStores(query).then(
  //     (value) {
  //       loadingMoreResults = false;

  //       if (value.errorMessages != null) {
  //         emit(GetStoresErrorState(value.errorMessages!));
  //       } else if (value.errors != null) {
  //         emit(GetStoresErrorState(value.errors!));
  //       } else {
  //         endLoadingFirstTime = true;

  //         List<PlaceDetails> storesList = [];

  //         value.data.forEach((item) {
  //           storesList.add(PlaceDetails.fromJson(item));
  //         });

  //         if (query['page'] != 1) {
  //           debugPrint('----- lode more ');
  //           stores.addAll(storesList);
  //         } else {
  //           stores.clear();
  //           stores.addAll(storesList);
  //         }
  //       }
  //     },
  //   );
  // }

