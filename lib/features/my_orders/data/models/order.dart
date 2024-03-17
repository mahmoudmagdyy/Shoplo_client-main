import 'package:shoplo_client/features/chat/data/models/uploader.dart';

import '../../../categories/data/models/categories_model.dart';
import '../../../products/data/models/product.dart';

class OrderModel {
  OrderModel({
    required this.id,
    required this.user,
    required this.status,
    required this.paymentMethod,
    required this.userAddress,
    required this.addedTax,
    required this.subtotal,
    required this.promoCodeDiscount,
    required this.total,
    required this.walletPayout,
    required this.remainAfterWalletUse,
    required this.notes,
    required this.bankTransfer,
    required this.invoice,
    required this.createdAt,
    required this.statuses,
    required this.adminNotes,
    required this.orderType,
    required this.store,
    required this.storeLat,
    required this.storeLong,
    required this.storeAddress,
    required this.deliveryUser,
    required this.deliveryCharge,
    required this.deliveryDate,
    required this.deliveryDateTo,
    required this.offerDiscount,
    required this.items,
    required this.isRate,
    required this.rejectReason,
  });
  late final int id;
  late final User user;
  late final Status status;
  late final PaymentMethod? paymentMethod;
  late final UserAddress? userAddress;
  late final String addedTax;
  late final String subtotal;
  late final String promoCodeDiscount;
  late final String total;
  late final String walletPayout;
  late final String remainAfterWalletUse;
  late final String notes;
  late final BankTransfer? bankTransfer;
  late final String invoice;
  late final String createdAt;
  late final List<Statuses> statuses;
  late final String adminNotes;
  late final String orderType;
  late final Store store;
  late final String storeLat;
  late final String storeLong;
  late final String storeName;
  late final String storeImage;
  late final String storeAddress;
  late final DeliveryUser? deliveryUser;
  late final String deliveryCharge;
  late final String deliveryDate;
  late final String deliveryDateTo;
  late final String offerDiscount;
  late final List<Items> items;
  late final int itemCount;
  late final bool isRate;
  late final String rejectReason;
  late final List<ScheduledItem> scheduledItems;
  late final ScheduledProcessStatus? scheduledProcessStatus;
  late final ScheduledProcessStatus? shippingProcessStatus;
  late final List<Shipping>? shippings;
  late final List<ShippingAddress>? addresses;
  late final ShippingAddress? sender;
  late final ShippingAddress? receiver;

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = User.fromJson(json['user']);
    status = Status.fromJson(json['status']);
    paymentMethod = json['payment_method'] != null ? PaymentMethod.fromJson(json['payment_method']) : null;
    userAddress = json['user_address'] != null ? UserAddress.fromJson(json['user_address']) : null;

    addedTax = json['added_tax'] ?? "";
    subtotal = json['subtotal'] ?? "";
    promoCodeDiscount = json['promo_code_discount'].toString();
    total = json['total'].toString();
    walletPayout = json['wallet_payout'] ?? "";
    remainAfterWalletUse = json['remain_after_wallet_use'] ?? "";
    notes = json['notes'] ?? '';
    bankTransfer = json['bank_transfer'] != null ? BankTransfer.fromJson(json['bank_transfer']) : null;
    invoice = json['invoice'];
    createdAt = json['created_at'];
    statuses = json['statuses'] != null ? List.from(json['statuses']).map((e) => Statuses.fromJson(e)).toList() : [];
    adminNotes = json['admin_notes'] ?? '';
    orderType = json['order_type'];
    store = json['store'] != null ? Store.fromJson(json['store']) : Store(id: 0, name: '', type: '', isActive: false);
    storeLat = json['store_lat'];
    storeLong = json['store_long'];
    storeName = json['store_name'] ?? "";
    storeImage = json['store_image'] ?? "https://cc-gs.com/shopLo-backend/public/assets/images/default/default.jpg"; //live
    // "https://shoplo.fudex-tech.net/shopLo-backend/public/assets/images/default/default.jpg";//demo
    storeAddress = json['store_address'] ?? "";
    deliveryUser = json['delivery_user'] != null ? DeliveryUser.fromJson(json['delivery_user']) : null;
    deliveryCharge = json['delivery_charge'];
    deliveryDate = json['delivery_date'];
    deliveryDateTo = json['delivery_date_to'];
    offerDiscount = json['offer_discount'] ?? "";
    items = json['items'] != null ? List.from(json['items']).map((e) => Items.fromJson(e)).toList() : [];
    itemCount = json['item_count'] ?? 0;
    isRate = json['is_rated'];
    rejectReason = json['reject_reason'] ?? '';
    scheduledItems = json['scheduleds'] != null ? List.from(json['scheduleds']).map((e) => ScheduledItem.fromJson(e)).toList() : [];
    scheduledProcessStatus = json['scheduled_process_status'] != null ? ScheduledProcessStatus.fromJson(json['scheduled_process_status']) : null;
    shippingProcessStatus = json['shipping_process_status'] != null ? ScheduledProcessStatus.fromJson(json['shipping_process_status']) : null;
    shippings = json['shippings'] != null ? List.from(json['shippings']).map((e) => Shipping.fromJson(e)).toList() : null;
    addresses = json['addresses'] != null ? List.from(json['addresses']).map((e) => ShippingAddress.fromJson(e)).toList() : null;
    sender = json['sender'] != null ? ShippingAddress.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null ? ShippingAddress.fromJson(json['receiver']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user.toJson();
    data['status'] = status.toJson();
    data['payment_method'] = paymentMethod?.toJson();
    data['user_address'] = userAddress?.toJson();
    data['added_tax'] = addedTax;
    data['subtotal'] = subtotal;
    data['promo_code_discount'] = promoCodeDiscount;
    data['total'] = total.toString();
    data['wallet_payout'] = walletPayout;
    data['remain_after_wallet_use'] = remainAfterWalletUse;
    data['notes'] = notes;
    data['bank_transfer'] = bankTransfer;
    data['invoice'] = invoice;
    data['created_at'] = createdAt;
    data['statuses'] = statuses.map((e) => e.toJson()).toList();
    data['admin_notes'] = adminNotes;
    data['order_type'] = orderType;
    data['store'] = store.toJson();
    data['store_lat'] = storeLat;
    data['store_long'] = storeLong;
    data['store_name'] = storeName;
    data['store_image'] = storeImage;
    data['store_address'] = storeAddress;
    data['delivery_user'] = deliveryUser!.toJson();
    data['delivery_charge'] = deliveryCharge;
    data['delivery_date'] = deliveryDate;
    data['delivery_date_to'] = deliveryDateTo;
    data['offer_discount'] = offerDiscount;
    data['items'] = items.map((e) => e.toJson()).toList();
    data['item_count'] = itemCount;
    data['is_rated'] = isRate;
    data['reject_reason'] = rejectReason;
    return data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.type,
    required this.city,
    required this.isActive,
    required this.createdAt,
    required this.verificationCode,
  });
  late final int id;
  late final String name;
  late final String countryCode;
  late final String phone;
  late final String email;
  late final String avatar;
  late final String type;
  late final String city;
  late final bool isActive;
  late final String createdAt;
  late final String verificationCode;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
    avatar = json['avatar'];
    type = json['type'];
    city = json['city'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    verificationCode = json['verification_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    data['type'] = type;
    data['city'] = city;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['verification_code'] = verificationCode;
    return data;
  }
}

class Status {
  Status({
    required this.id,
    required this.name,
    required this.key,
    required this.type,
    required this.isActive,
  });
  late final int id;
  late final String name;
  late final String key;
  late final String type;
  late final int isActive;

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    key = json['key'];
    type = json['type'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['key'] = key;
    data['type'] = type;
    data['is_active'] = isActive;
    return data;
  }
}

class PaymentMethod {
  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
  });
  late final int id;
  late final String name;
  late final String type;
  late final int isActive;

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['is_active'] = isActive;
    return data;
  }
}

class UserAddress {
  UserAddress({
    required this.id,
    required this.title,
    required this.phone,
    required this.isPrimary,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.nearestLandmarks,
    required this.city,
  });
  late final int id;
  late final String title;
  late final String phone;
  late final bool isPrimary;
  late final String address;
  late final String latitude;
  late final String longitude;
  late final String nearestLandmarks;
  late final City city;

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    phone = json['phone'];
    isPrimary = json['is_primary'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nearestLandmarks = json['nearest_landmarks'] ?? "";
    city = City.fromJson(json['city']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['phone'] = phone;
    data['is_primary'] = isPrimary;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['nearest_landmarks'] = nearestLandmarks;
    data['city'] = city.toJson();
    return data;
  }
}

class City {
  City({
    required this.id,
    required this.name,
    required this.state,
    required this.isActive,
    required this.createdAt,
  });
  late final int id;
  late final String name;
  late final State state;
  late final bool isActive;
  late final String createdAt;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['state'] != null) {
      state = State.fromJson(json['state']);
    }
    isActive = json['is_active'];
    createdAt = json['created_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['state'] = state.toJson();
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}

class State {
  State({
    required this.id,
    required this.name,
    required this.country,
    required this.isActive,
    required this.createdAt,
  });
  late final int id;
  late final String name;
  late final Country country;
  late final bool isActive;
  late final String createdAt;

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = Country.fromJson(json['country']);
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country'] = country.toJson();
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.phoneCode,
    required this.flag,
    required this.isActive,
    required this.createdAt,
  });
  late final int id;
  late final String name;
  late final String code;
  late final String phoneCode;
  late final String flag;
  late final bool isActive;
  late final String createdAt;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    phoneCode = json['phone_code'];
    flag = json['flag'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['phone_code'] = phoneCode;
    data['flag'] = flag;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}

class Statuses {
  Statuses({
    required this.status,
    required this.createdAt,
    required this.reason,
  });
  late final Status status;
  late final String createdAt;
  late final String reason;

  Statuses.fromJson(Map<String, dynamic> json) {
    status = Status.fromJson(json['status']);
    createdAt = json['created_at'];
    reason = json['reason'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status.toJson();
    data['created_at'] = createdAt;
    data['reason'] = reason;
    return data;
  }
}

class Store {
  Store({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
  });
  late final int id;
  late final String name;
  late final String type;
  late final bool isActive;

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['is_active'] = isActive;
    return data;
  }
}

class Items {
  Items({
    required this.id,
    required this.product,
    required this.quantity,
    required this.productPrice,
    required this.offerDiscount,
    required this.priceAfterDiscount,
    required this.total,
    required this.freeProduct,
  });
  late final int id;
  late final ProductModel product;
  late final int quantity;
  late final String productPrice;
  late final String offerDiscount;
  late final String priceAfterDiscount;
  late final String total;
  late final String freeProduct;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
    quantity = json['quantity'];
    productPrice = json['product_price'];
    offerDiscount = json['offer_discount'];
    priceAfterDiscount = json['price_after_discount'];
    total = json['total'];
    freeProduct = json['free_product'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product.toJson();
    data['quantity'] = quantity;
    data['product_price'] = productPrice;
    data['offer_discount'] = offerDiscount;
    data['price_after_discount'] = priceAfterDiscount;
    data['total'] = total;
    data['free_product'] = freeProduct;
    return data;
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.catalog,
    required this.store,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.quantity,
    required this.barcode,
    required this.maxPurchaseQuantity,
    required this.madeIn,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String catalog;
  late final Store store;
  late final String price;
  late final bool isActive;
  late final String createdAt;
  late final int quantity;
  late final String barcode;
  late final int maxPurchaseQuantity;
  late final String madeIn;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    catalog = json['catalog'];
    store = Store.fromJson(json['store']);
    price = json['price'];
    isActive = json['is_active'];
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
    data['image'] = image;
    data['catalog'] = catalog;
    data['store'] = store.toJson();
    data['price'] = price;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['quantity'] = quantity;
    data['barcode'] = barcode;
    data['max_purchase_quantity'] = maxPurchaseQuantity;
    data['made_in'] = madeIn;
    return data;
  }
}

class DeliveryUser {
  DeliveryUser({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.type,
    required this.city,
    required this.isActive,
    required this.createdAt,
    required this.verificationCode,
  });
  late final int id;
  late final String name;
  late final String countryCode;
  late final String phone;
  late final String email;
  late final String avatar;
  late final String type;
  late final City city;
  late final bool isActive;
  late final String createdAt;
  late final String verificationCode;

  DeliveryUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
    avatar = json['avatar'];
    type = json['type'];
    city = City.fromJson(json['city']);
    isActive = json['is_active'];
    createdAt = json['created_at'];
    verificationCode = json['verification_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    data['type'] = type;
    data['city'] = city.toJson();
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['verification_code'] = verificationCode;
    return data;
  }
}

class BankTransfer {
  BankTransfer({
    required this.id,
    required this.depositorName,
    required this.depositAmount,
    required this.depositReceipt,
    required this.fileType,
  });
  late final int id;
  late final String depositorName;
  late final String depositAmount;
  late final String depositReceipt;
  late final String fileType;

  BankTransfer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    depositorName = json['depositor_name'];
    depositAmount = json['deposit_amount'];
    depositReceipt = json['deposit_receipt'];
    fileType = json['file_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['depositor_name'] = depositorName;
    data['deposit_amount'] = depositAmount;
    data['deposit_receipt'] = depositReceipt;
    data['file_type'] = fileType;
    return data;
  }
}

class ScheduledItem {
  int? id;

  final String storeLat;
  final String storeLong;
  final String storeAddress;
  final String storeImage;
  final String storeName;
  final City storeCity;
  final String notes;
  final String subtotal;
  final String actualPrice;
  final String receipt;
  final String reason;
  final ScheduledItemStatus status;

  ScheduledItem(
      {this.id,
      required this.storeLat,
      required this.storeLong,
      required this.storeAddress,
      required this.storeImage,
      required this.storeName,
      required this.storeCity,
      required this.notes,
      required this.actualPrice,
      required this.receipt,
      required this.status,
      required this.reason,
      required this.subtotal});
// factory
  ScheduledItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        storeLat = json['store_lat'] ?? "",
        storeLong = json['store_long'] ?? "",
        storeAddress = json['store_address'] ?? "",
        storeImage = json['store_image'] ?? "",
        storeName = json['store_name'] ?? "",
        storeCity = City.fromJson(json['store_city']),
        notes = json['notes'] ?? "",
        actualPrice = json['actual_price']?.toString() ?? "",
        receipt = json['receipt'] ?? "",
        reason = json['reason'] ?? "",
        status = ScheduledItemStatus.fromJson(json['status']),
        subtotal = json['subtotal'] ?? "";
}

class ScheduledItemStatus {
  final int id;
  final String name;
  final String key;
  final String type;
  final int isActive;

  ScheduledItemStatus({required this.id, required this.name, required this.key, required this.type, required this.isActive});

  ScheduledItemStatus.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        key = json['key'],
        type = json['type'],
        isActive = json['is_active'];
}

class ScheduledProcessStatus {
  final int id;
  final String name;
  final String key;
  final String type;
  final int isActive;

  ScheduledProcessStatus({required this.id, required this.name, required this.key, required this.type, required this.isActive});

  ScheduledProcessStatus.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        key = json['key'],
        type = json['type'],
        isActive = json['is_active'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['key'] = key;
    data['type'] = type;
    data['is_active'] = isActive;
    return data;
  }
}

class ShippingAddress {
  final int id;
  final City city;
  final dynamic userAddress;
  final String address;
  final String latitude;
  final String longitude;
  final String name;
  final String phone;
  final String idNumber;
  final String type;

  ShippingAddress({
    required this.id,
    required this.city,
    required this.userAddress,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.phone,
    required this.idNumber,
    required this.type,
  });

  //from json
  ShippingAddress.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        city = City.fromJson(json['city']),
        userAddress = json['user_address'],
        address = json['address'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        name = json['name'],
        phone = json['phone'],
        idNumber = json['id_number'] ?? "",
        type = json['type'];
}

class Shipping {
  final int id;
  final Category category;
  final String description;
  final String weight;
  final String width;
  final String height;
  final String length;
  final int isPackaging;
  final int isBreakable;
  final int isRefrigeration;
  final String paidBy;
  final String isReceived;
  final dynamic receivedAt;
  final String receivedBy;
  final String createdAt;
  final int status;
  final List<UploaderModel> images;

  Shipping({
    required this.id,
    required this.category,
    required this.description,
    required this.weight,
    required this.width,
    required this.height,
    required this.length,
    required this.isPackaging,
    required this.isBreakable,
    required this.isRefrigeration,
    required this.paidBy,
    required this.isReceived,
    required this.receivedAt,
    required this.receivedBy,
    required this.createdAt,
    required this.status,
    required this.images,
  });

  //from json
  Shipping.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        category = Category.fromJson(json['category']),
        description = json['description'],
        weight = json['weight'],
        width = json['width'],
        height = json['height'],
        length = json['length'],
        isPackaging = json['is_packaging'],
        isBreakable = json['is_breakable'],
        isRefrigeration = json['is_refrigeration'],
        paidBy = json['paid_by'],
        isReceived = json['is_received'],
        receivedAt = json['received_at'],
        receivedBy = json['received_by'],
        createdAt = json['created_at'],
        images = json['attachments'] != null ? List.from(json['attachments']).map((e) => UploaderModel.fromJson(e)).toList() : [],
        status = json['status'];
}
