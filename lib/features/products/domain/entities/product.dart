import 'package:equatable/equatable.dart';

import 'store.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final String catalog;
  final Store store;
  final String price;
  final bool isActive;
  final String createdAt;
  final String saleQty;
  final int quantity;
  final String barcode;
  String? currency;
  final int maxPurchaseQuantity;
  final String madeIn;

  ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.catalog,
    required this.store,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.saleQty,
    required this.quantity,
    required this.barcode,
    this.currency,
    required this.maxPurchaseQuantity,
    required this.madeIn,
  });

  @override
  List<Object?> get props => [id, name];
}
