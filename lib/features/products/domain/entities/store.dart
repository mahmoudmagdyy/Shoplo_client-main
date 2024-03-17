import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final int id;
  final String name;
  final String type;
  final bool isActive;
  const Store({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json['id'],
        name: json['name'],
        type: json['type'] ?? '',
        isActive: json['is_active']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['is_active'] = isActive;
    return data;
  }

  @override
  List<Object?> get props => [id, name];
}
