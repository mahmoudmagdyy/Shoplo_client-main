part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

/// get all Cart
class CartLoadingNextPageState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final List<CartModal> cartProducts;
  const CartSuccessState(this.cartProducts);
}

class CartErrorState extends CartState {
  final String error;
  const CartErrorState(this.error);
}

/// add to Cart states
class AddToCartLoadingState extends CartState {}

class AddToCartLoadedState extends CartState {
  final CartModal cartProduct;
  const AddToCartLoadedState(this.cartProduct);
}

class AddToCartErrorState extends CartState {
  final String error;
  const AddToCartErrorState(this.error);
}

/// update item in cart
class UpdateItemLoadingState extends CartState {
  final int id;
  const UpdateItemLoadingState(this.id);
}

class UpdateItemSuccessState extends CartState {
  final List<CartModal> updatedProducts;
  const UpdateItemSuccessState(this.updatedProducts);
}

class UpdateItemErrorState extends CartState {
  final String error;
  const UpdateItemErrorState(this.error);
}

/// delete item from cart
class DeleteItemLoadingState extends CartState {
  final int id;
  const DeleteItemLoadingState(this.id);
}

class DeleteItemSuccessState extends CartState {
  final List<CartModal> cartProducts;
  const DeleteItemSuccessState(this.cartProducts);
}

class DeleteItemErrorState extends CartState {
  final String error;
  const DeleteItemErrorState(this.error);
}

class AddToCartCountLoadingState extends CartState {}

class AddToCartCountSuccessState extends CartState {}

class AddCartAddressSuccessState extends CartState {}
