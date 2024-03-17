import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../../addresses/data/models/address_model.dart';
import '../../../products/domain/entities/store.dart';
import '../../data/models/cart.dart';
import '../../data/repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  final repository = serviceLocator.get<CartRepository>();
  AddressModel? cartAddress;
  List<dynamic> warranties = [];
  final List<CartModal> cart = [];
  late Store? cartStore;
  int cartCount = 0;
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;

  String subTotal = '0';

  Map<String, dynamic> query = {
    'page': 1,
    'per_page': 10,
  };
  int currentItemId = -1;

  void setCartAddress(AddressModel add) {
    cartAddress = add;
    emit(AddCartAddressSuccessState());
  }

  void setCartCount(int num) {
    cartCount = num;
    emit(AddToCartCountLoadingState());
  }

  /// get all Cart
  void getCart(Map<String, dynamic> queryData) {
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      debugPrint('object 1 ');
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (query['page'] == 1) {
      emit(CartLoadingState());
    } else {
      emit(CartLoadingNextPageState());
    }

    repository.getCart().then(
      (value) {
        if (value.errorMessages != null) {
          emit(CartErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(CartErrorState(value.errors!));
        } else {
          endLoadingFirstTime = true;

          List<CartModal> cartList = [];

          value.data.forEach((item) {
            debugPrint(
                "🚀 ~ file: cart_cubit.dart ~ line 65 ~ CartCubit ~ value.data.forEach ~ $item");
            cartList.add(CartModal.fromJson(item));
          });

          if (cartList.isNotEmpty) {
            debugPrint('cartList: ${cartList[0]}', wrapWidth: 1024);
            cartStore = cartList[0].product.store;
          }
          debugPrint('cart ££££££$cartList}');

          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            cart.addAll(cartList);
          } else {
            cart.clear();
            cart.addAll(cartList);
          }
          cartCount = value.meta['total'];
          if (cart.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (cart.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }
          if (value.subtotal != '') {
            subTotal = value.subtotal!;
          }
          emit(CartSuccessState(cart));
        }
      },
    );
  }

  //addToCart
  void addToCart(id, values) {
    emit(AddToCartLoadingState());
    currentItemId = id;
    repository.addToCart(values).then(
      (value) {
        debugPrint(
            'res add to Cart cubit================================ ${value.data}');

        if (value.errorMessages != null) {
          emit(AddToCartErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(AddToCartErrorState(value.errors!));
        } else {
          cartCount += 1;
          emit(AddToCartLoadedState(CartModal.fromJson(value.data)));
        }
      },
    );
  }

  /// update items in cart
  void updateItemInCart(
    int id,
    int newQuantity,
  ) {
    emit(UpdateItemLoadingState(id));
    currentItemId = id;
    Map<String, dynamic> data = {
      'id': id,
      'quantity': newQuantity,
    };

    repository.updateItemInCart(data).then(
      (value) {
        if (value.errorMessages != null) {
          emit(UpdateItemErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UpdateItemErrorState(value.errors!));
        } else {
          int index = cart.indexWhere((item) => item.id == id);
          // debugPrint('cart====>${cart.toString()}');
          // cart[index]['quantity'] = newQuantity;
          getCart({});
          emit(UpdateItemSuccessState(cart));
        }
      },
    );
  }

  /// delete items from cart
  void deleteItemFromCart(id) {
    currentItemId = id;
    emit(DeleteItemLoadingState(id));
    repository.deleteItemFromCart(id).then(
      (value) {
        if (value.errorMessages != null) {
          emit(DeleteItemErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(DeleteItemErrorState(value.errors!));
        } else {
          cart.removeWhere((item) => item.id == id);
          getCart({});
          emit(DeleteItemSuccessState(cart));
        }
      },
    );
  }
}

extension GetProduct on List<CartModal> {
  CartModal? getProduct(int id) {
    var items = where((element) => element.product.id == id);
    if (items.isNotEmpty) {
      return items.first;
    }
    return null;
  }
}
