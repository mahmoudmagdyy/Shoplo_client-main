import '../../../../core/core_model/app_response.dart';

abstract class CartInterface {
  Future<AppResponse> getCart();
  Future<AppResponse> addToCart(data);
  Future<AppResponse> updateItemInCart(data);
  Future<AppResponse> deleteItemFromCart(id);
}
