part of 'product_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsSelectedCategory extends ProductsState {}

class GetStoresProductsLoadingState extends ProductsState {}

class GetStoresProductsLoadingNextPageState extends ProductsState {}

class GetStoresProductsSuccessState extends ProductsState {
  final List<ProductModel> products;
  const GetStoresProductsSuccessState(this.products);
}

class GetStoresProductsErrorState extends ProductsState {
  final String error;
  const GetStoresProductsErrorState(this.error);
}
