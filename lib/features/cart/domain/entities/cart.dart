import 'package:equatable/equatable.dart';
import 'package:shoplo_client/features/products/data/models/product.dart';

class CartEntity extends Equatable {
  const CartEntity({
    required this.id,
    required this.product,
    required this.quantity,
    required this.createdAt,
  });
  final int id;
  final ProductModel product;
  final int quantity;
  final String createdAt;

  @override
  List<Object> get props => [id, product, quantity, createdAt];
}
