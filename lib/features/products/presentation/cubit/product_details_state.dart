part of 'product_details_cubit.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

// Ad details

class GetProductDetailsLoadingState extends ProductDetailsState {}

class GetProductDetailsSuccessState extends ProductDetailsState {
  final ProductDetailsModal productDetails;
  const GetProductDetailsSuccessState(this.productDetails);
}

class GetProductDetailsErrorState extends ProductDetailsState {
  final String error;
  const GetProductDetailsErrorState(this.error);
}
