import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../data/models/product.dart';
import '../../data/repositories/products_repository.dart';

part 'product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  static ProductsCubit get(context) => BlocProvider.of(context);
  final repository = serviceLocator.get<ProductsRepository>();
  TextEditingController searchController = TextEditingController();
  int totalCount = 0;
  final List<ProductModel> products = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  void getStoresProducts(Map<String, dynamic> queryData) async {
    debugPrint('QUERY DATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      debugPrint('object 1 ');
      products.clear();
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (query['page'] == 1) {
      products.clear();
      emit(GetStoresProductsLoadingState());
    } else {
      loadingMoreResults = true;
      emit(GetStoresProductsLoadingNextPageState());
    }
    repository.getStoresProducts(query).then(
      (value) {
        loadingMoreResults = false;

        if (value.errorMessages != null) {
          emit(GetStoresProductsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetStoresProductsErrorState(value.errors!));
        } else {
          endLoadingFirstTime = true;

          List<ProductModel> productsList = [];

          value.data.forEach((item) {
            productsList.add(ProductModel.fromJson(item));
          });
          totalCount = value.meta['total'];
          debugPrint('_myValues ${productsList.length}');
          debugPrint('query page ${query['page']}');
          debugPrint(' request total ${value.meta['total']}');
          debugPrint(' request last_page ${value.meta['last_page']}');

          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            products.addAll(productsList);
          } else {
            products.clear();
            products.addAll(productsList);
          }
          if (products.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (products.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(GetStoresProductsSuccessState(products));
        }
      },
    );
  }

  refreshAfterSelectCategory() {
    emit(GetStoresProductsLoadingState());
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
