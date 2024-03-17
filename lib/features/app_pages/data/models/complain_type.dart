import 'dart:convert';

import 'package:equatable/equatable.dart';

List<ComplainTypeModel> complainTypeModelFromJson(String str) =>
    List<ComplainTypeModel>.from(
        json.decode(str).map((x) => ComplainTypeModel.fromJson(x)));

String complainTypeModelToJson(List<ComplainTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplainTypeModel extends Equatable {
  const ComplainTypeModel({
    required this.id,
    required this.key,
    required this.type,
    required this.name,
    required this.value,
  });

  final String id;
  final String key;
  final String type;
  final String name;
  final String value;

  factory ComplainTypeModel.fromJson(Map<String, dynamic> json) =>
      ComplainTypeModel(
        id: json["id"],
        key: json["key"],
        type: json["type"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "type": type,
        "name": name,
        "value": value,
      };
  @override
  String toString() => 'id: $id value: $value key: $key name $name type$type';

  @override
  List<Object?> get props => [id, value, key, type, name];
}
