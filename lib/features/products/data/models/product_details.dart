class ProductDetailsModal {
  late final int id;
  late final String name;
  late final String description;
  late final List<dynamic> tags;
  late final bool isActive;
  late final Ar ar;
  late final En en;
  late final String image;
  late final String catalog;
  late final List<Attachments> attachments;
  late final Store store;
  late final String price;
  late final String createdAt;
  late final int quantity;
  late final String barcode;
  late final int maxPurchaseQuantity;
  late final String madeIn;

  ProductDetailsModal({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
    required this.isActive,
    required this.ar,
    required this.en,
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

  ProductDetailsModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    tags = List.castFrom<dynamic, dynamic>(json['tags']);
    isActive = json['is_active'];
    ar = Ar.fromJson(json['ar']);
    en = En.fromJson(json['en']);
    image = json['image'];
    catalog = json['catalog'];
    attachments = List.from(json['attachments'])
        .map((e) => Attachments.fromJson(e))
        .toList();
    store = Store.fromJson(json['store']);
    price = json['price'];
    createdAt = json['created_at'];
    quantity = json['quantity'];
    barcode = json['barcode'] ?? '';
    maxPurchaseQuantity = json['max_purchase_quantity'];
    madeIn = json['made_in'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['tags'] = tags;
    data['is_active'] = isActive;
    data['ar'] = ar.toJson();
    data['en'] = en.toJson();
    data['image'] = image;
    data['catalog'] = catalog;
    data['attachments'] = attachments.map((e) => e.toJson()).toList();
    data['store'] = store.toJson();
    data['price'] = price;
    data['created_at'] = createdAt;
    data['quantity'] = quantity;
    data['barcode'] = barcode;
    data['max_purchase_quantity'] = maxPurchaseQuantity;
    data['made_in'] = madeIn;
    return data;
  }
}

class Ar {
  Ar({
    required this.name,
    required this.description,
    required this.tags,
  });
  late final String name;
  late final String description;
  late final List<dynamic> tags;

  Ar.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    tags = List.castFrom<dynamic, dynamic>(json['tags']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['tags'] = tags;
    return data;
  }
}

class En {
  En({
    required this.name,
    required this.description,
    required this.tags,
  });
  late final String name;
  late final String description;
  late final List<dynamic> tags;

  En.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    tags = List.castFrom<dynamic, dynamic>(json['tags']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['tags'] = tags;
    return data;
  }
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
  late final int id;
  late final String name;
  late final String file;
  late final String folder;
  late final String type;
  late final String description;

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    file = json['file'];
    folder = json['folder'];
    type = json['type'];
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['file'] = file;
    data['folder'] = folder;
    data['type'] = type;
    data['description'] = description;
    return data;
  }
}

class Store {
  Store({
    required this.id,
    required this.name,
    required this.username,
    required this.image,
    required this.avatar,
    required this.type,
    required this.phone,
    required this.email,
    required this.isActive,
    required this.isFeatured,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.createdAt,
  });
  late final int id;
  late final String name;
  late final String username;
  late final String image;
  late final String avatar;
  late final String type;
  late final String phone;
  late final String email;
  late final bool isActive;
  late final bool isFeatured;
  late final String latitude;
  late final String longitude;
  late final String address;
  late final String createdAt;

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    image = json['image'];
    avatar = json['avatar'];
    type = json['type'];
    phone = json['phone'];
    email = json['email'];
    isActive = json['is_active'];
    isFeatured = json['is_featured'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'] ?? '';
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['image'] = image;
    data['avatar'] = avatar;
    data['type'] = type;
    data['phone'] = phone;
    data['email'] = email;
    data['is_active'] = isActive;
    data['is_featured'] = isFeatured;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['created_at'] = createdAt;
    return data;
  }
}
