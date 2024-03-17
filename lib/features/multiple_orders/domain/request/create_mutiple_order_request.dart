import 'package:shoplo_client/features/addresses/data/models/address_model.dart';
import 'package:shoplo_client/features/addresses/domain/entities/city.dart';
import 'package:shoplo_client/features/addresses/domain/entities/country.dart';
import 'package:shoplo_client/features/addresses/domain/entities/state.dart';
import 'package:shoplo_client/features/multiple_orders/data/models/multiple_order_total.dart';

import '../../../../core/config/map_config.dart';

class CreateMultipleOrderRequest {
  Country? country;
  StateEntity? state;
  City? fromCity;
  AddressModel? toAddress;
  DateTime? from;
  DateTime? to;
  String orderType = 'scheduled';
  List<OrderDescriptionModel> stores = [];
  MultipleOrderTotal? total;

  double get orderTotal {
    double total = 0;
    for (var element in stores) {
      total += double.tryParse(element.subtotal) ?? 0;
    }
    return total;
  }

  //toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (state != null) {
      data['state'] = state!.id;
    }
    if (fromCity != null) {
      data['from_city'] = fromCity!.id;
    }
    if (toAddress != null) {
      data['user_address_id'] = toAddress!.id;
    }
    if (from != null) {
      data['delivery_date'] = from!.toIso8601String();
    }
    if (to != null) {
      data['delivery_date_to'] = to!.toIso8601String();
    }
    if (orderType.isNotEmpty) {
      data['order_type'] = orderType;
    }
    if (stores.isNotEmpty) {
      data['stores'] = stores.map((e) => e.toJson()).toList();
    }

    return data;
  }

  setState(StateEntity? state) {
    this.state = state;
    fromCity = null;
  }

  setCountry(Country? country) {
    this.country = country;
    state = null;
    fromCity = null;
  }
}

class OrderDescriptionModel {
  String storeAddress;
  String notes;
  String subtotal;
  String storeLat;
  String storeLng;
  String storeName;
  String storeImage;
  OrderDescriptionModel({
    this.storeAddress = "",
    this.notes = "",
    this.subtotal = "",
    this.storeLat = "",
    this.storeLng = "",
    this.storeName = "",
    this.storeImage = "",
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storeAddress.isNotEmpty) {
      data['store_address'] = storeAddress;
    }
    if (notes.isNotEmpty) {
      data['notes'] = notes;
    }
    if (subtotal.isNotEmpty) {
      data['subtotal'] = subtotal;
    }
    if (storeLat.isNotEmpty) {
      data['store_lat'] = storeLat;
    }
    if (storeLng.isNotEmpty) {
      data['store_long'] = storeLng;
    }
    if (storeName.isNotEmpty) {
      data['store_name'] = storeName;
    }
    if (storeImage.isNotEmpty) {
      data['store_image'] =
          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=120&photo_reference=$storeImage&key=${MapConfiguration.apiKeyMaps}";
    }

    return data;
  }
}
