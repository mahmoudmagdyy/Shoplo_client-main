import 'package:shoplo_client/features/addresses/domain/entities/city.dart';
import 'package:shoplo_client/features/chat/data/models/uploader.dart';

class ShipByGlobalEntity {
  ShipByGlobalAddress senderAddress = ShipByGlobalAddress();
  ShipByGlobalAddress receiverAddress = ShipByGlobalAddress();
  ShipmentDetails shipmentDetails = ShipmentDetails();
  String? description;
  String type = "shipping";
  String orderType = "outer";
  String? deliveryDate;
  String? deliveryDateTo;
  int? senderCountry;
  int? receiverCountry;

  toJson() {
    final result = <String, dynamic>{};
    senderAddress.type = "sender";
    receiverAddress.type = "receiver";
    result.addAll({
      'addresses': [
        senderAddress.toJson(),
        receiverAddress.toJson(),
      ]
    });
    result.addAll({
      'shippings': [shipmentDetails.toJson()]
    });
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'type': type});
    result.addAll({'order_type': orderType});
    result.addAll({'delivery_date': deliveryDate});
    result.addAll({'delivery_date_to': deliveryDateTo});

    return result;
  }
}

class ShipmentDetails {
  double width = 0;
  double height = 0;
  double length = 0;
  double weight = 0;
  String? description;
  int? categoryId;
  bool isPackage = false;
  bool isRefrigeration = false;
  bool isBreakable = false;
  String paidBay = "sender";
  List<UploaderModel> attachments = [];

//toJson

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll({'width': width});
    result.addAll({'height': height});
    result.addAll({'length': length});
    result.addAll({'weight': weight});
    if (description != null) {
      result.addAll({'description': description});
    }
    if (categoryId != null) {
      result.addAll({'category_id': categoryId});
    }
    result.addAll({'is_packaging': isPackage});
    result.addAll({'is_refrigeration': isRefrigeration});
    result.addAll({'is_breakable': isBreakable});
    result.addAll({'paid_by': paidBay});
    result.addAll({'attachments': attachments.map((e) => e.toJson()).toList()});

    return result;
  }
}

class ShipByGlobalAddress {
  String? idNumber;
  String? name;
  String? phone;
  String? address;
  City? city;
  String? latitude;
  String? longitude;
  String? type;

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (idNumber != null) {
      result.addAll({'id_number': idNumber});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (city != null) {
      result.addAll({'city_id': city?.id});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    if (type != null) {
      result.addAll({'type': type});
    }

    return result;
  }
}
