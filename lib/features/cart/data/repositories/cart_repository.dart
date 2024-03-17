import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/cart_interface.dart';
import '../datasources/cart_data_provider.dart';

class CartRepository implements CartInterface {
  final CartDataProvider cartDataProvider;
  CartRepository(this.cartDataProvider);

  @override
  Future<AppResponse> addToCart(data) {
    return cartDataProvider.addToCart(data);
  }

  @override
  Future<AppResponse> getCart() {
    return cartDataProvider.getCart();
  }

  @override
  Future<AppResponse> updateItemInCart(data) {
    return cartDataProvider.updateItemInCart(data);
  }

  @override
  Future<AppResponse> deleteItemFromCart(id) {
    return cartDataProvider.deleteItemFromCart(id);
  }
}
