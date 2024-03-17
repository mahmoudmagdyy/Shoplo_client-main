import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../data/models/product_details.dart';
import '../../data/repositories/products_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  static ProductDetailsCubit get(context) => BlocProvider.of(context);
  final repository = serviceLocator.get<ProductsRepository>();

  /// get Product details
  void getProductDetails(id) {
    emit(GetProductDetailsLoadingState());

    repository.getProductDetails(id).then(
      (value) {
        debugPrint(
            "🚀 ~ file: product_details_cubit.dart ~ line 22 ~ ProductDetailsCubit ~ voidgetProductDetails ~ $value");
        if (value.errorMessages != null) {
          emit(GetProductDetailsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetProductDetailsErrorState(value.errors!));
        } else {
          ProductDetailsModal productDetails =
              ProductDetailsModal.fromJson(value.data);
          debugPrint("getProductDetails $productDetails");
          emit(GetProductDetailsSuccessState(productDetails));
        }
      },
    );
  }
}
