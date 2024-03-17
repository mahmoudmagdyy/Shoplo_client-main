import 'package:shoplo_client/features/products/data/models/product.dart';

import '../../domain/entities/cart.dart';

class CartModal extends CartEntity {
  const CartModal({
    required super.id,
    required super.product,
    required super.quantity,
    required super.createdAt,
  });

  factory CartModal.fromJson(Map<String, dynamic> json) {
    return CartModal(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      quantity: int.parse(json['quantity'].toString()),
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product.toJson();
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    return data;
  }
}
