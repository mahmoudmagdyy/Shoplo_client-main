import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoplo_client/features/categories/data/models/categories_model.dart';
import 'package:shoplo_client/features/products/presentation/cubit/product_categories_state.dart';

import '../../../categories/data/datasources/category_data_provider.dart';
import '../../../categories/data/repositories/categories_repository.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  ProductCategoryCubit() : super(ProductCategoryInitial());
  static final dataProvider = CategoriesDataProvider();
  static final CategoriesRepository repository =
      CategoriesRepository(dataProvider);

  int? selectedCategoryId;
  selectCategory(Category category) {
    // if (selectedCategoryId == category.id) {
    //   selectedCategoryId = null;
    //   emit(SelectProductCategoryState(category));
    //   return;
    // }
    selectedCategoryId = category.id;
    emit(SelectProductCategoryState(category));
  }

  int totalCount = 0;
  final List<Category> categories = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };

  void getCategories(Map<String, dynamic> queryData, {String? url}) async {
    debugPrint('QUERYDATA: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      debugPrint('object 1 ');
      categories.clear();
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (query['page'] == 1) {
      categories.clear();

      emit(GetProductCategoryLoadingState());
    } else {
      loadingMoreResults = true;
      emit(GetProductCategoryLoadingNextPageState());
    }
    repository.getCategories(query).then(
      (value) {
        loadingMoreResults = false;

        if (value.errorMessages != null) {
          emit(GetProductCategoryErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetProductCategoryErrorState(value.errors!));
        } else {
          endLoadingFirstTime = true;
          List<Category> ordersList = [];
          value.data.forEach((item) {
            ordersList.add(Category.fromJson(item));
          });

          debugPrint('_orders ${ordersList.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            categories.addAll(ordersList);
          } else {
            categories.clear();
            categories.add(Category(
              id: null,
              name: 'all',
              image: '',
            ));

            categories.addAll(ordersList);
          }
          if (categories.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (categories.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          debugPrint('orders ${categories.length}');
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(GetProductCategorySuccessState(categories));
        }
      },
    );
  }
}
