import '../../domain/entities/product.dart';
import '../../domain/entities/store.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.image,
    required super.catalog,
    required super.store,
    required super.price,
    required super.isActive,
    required super.createdAt,
    required super.saleQty,
    required super.quantity,
    required super.barcode,
    required super.maxPurchaseQuantity,
    required super.madeIn,
    super.currency,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      catalog: json['catalog'],
      store: Store.fromJson(json["store"]),
      price: json['price'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      saleQty: json['sale_qty'] ?? '',
      barcode: json['barcode'] ?? '',
      madeIn: json['made_in'] ?? '',
      currency: json['currency']["symbol"],
      maxPurchaseQuantity: json['max_purchase_quantity'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  @override
  String toString() => 'id: $id name: $name';
}
