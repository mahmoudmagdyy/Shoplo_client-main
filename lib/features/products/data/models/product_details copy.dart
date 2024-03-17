import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:shoplo_client/features/home/data/models/store.dart';

class ProductDetailsModal extends Equatable {
  final int id;
  final String name;
  final String description;
  // final List<dynamic> tags;
  final bool isActive;
  // final Ar ar;
  // final En en;
  final String image;
  final String catalog;
  final List<Attachments> attachments;
  final StoreModel store;
  final String price;
  final String createdAt;
  final int quantity;
  final String barcode;
  final int maxPurchaseQuantity;
  final String madeIn;

  const ProductDetailsModal({
    required this.id,
    required this.name,
    required this.description,
    // required this.tags,
    required this.isActive,
    // required this.ar,
    // required this.en,
    required this.image,
    required this.catalog,
    required this.attachments,
    required this.store,
    required this.price,
    required this.createdAt,
    required this.quantity,
    required this.barcode,
    required this.maxPurchaseQuantity,
    required this.madeIn,
  });
  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      // tags,
      isActive,
      // ar,
      // en,
      image,
      catalog,
      attachments,
      store,
      price,
      createdAt,
      quantity,
      barcode,
      maxPurchaseQuantity,
      madeIn,
    ];
  }

  factory ProductDetailsModal.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModal(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      catalog: json['catalog'],
      store: StoreModel.fromJson(json),
      price: json['price'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      barcode: json['barcode'] ?? '',
      madeIn: json['made_in'] ?? '',
      maxPurchaseQuantity: json['max_purchase_quantity'],
      quantity: json['quantity'],
      // ar: Ar.fromJson(json['ar']),
      attachments: const [],
      description: json['description'],
      // en: En.fromJson(json['en']),
      // tags: ,
    );
  }
}

class Ar {
  Ar({
    required this.name,
    required this.description,
    required this.tags,
  });
  final String name;
  final String description;
  final List<dynamic> tags;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'tags': tags,
    };
  }

  factory Ar.fromMap(Map<String, dynamic> map) {
    return Ar(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      tags: List<dynamic>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ar.fromJson(String source) => Ar.fromMap(json.decode(source));
}

class En {
  En({
    required this.name,
    required this.description,
    required this.tags,
  });
  final String name;
  final String description;
  final List<dynamic> tags;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'tags': tags,
    };
  }

  factory En.fromMap(Map<String, dynamic> map) {
    return En(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      tags: List<dynamic>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory En.fromJson(String source) => En.fromMap(json.decode(source));
}

class Attachments {
  Attachments({
    required this.id,
    required this.name,
    required this.file,
    required this.folder,
    required this.type,
    required this.description,
  });
  final int id;
  final String name;
  final String file;
  final String folder;
  final String type;
  final String description;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'file': file,
      'folder': folder,
      'type': type,
      'description': description,
    };
  }

  factory Attachments.fromMap(Map<String, dynamic> map) {
    return Attachments(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      file: map['file'] ?? '',
      folder: map['folder'] ?? '',
      type: map['type'] ?? '',
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachments.fromJson(String source) =>
      Attachments.fromMap(json.decode(source));
}
