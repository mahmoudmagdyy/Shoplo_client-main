import '../../domain/entities/store.dart';

class StoreModel extends StoreEntity {
  const StoreModel({
    required super.id,
    required super.name,
    required super.username,
    required super.image,
    required super.avatar,
    required super.phone,
    required super.email,
    required super.isActive,
    required super.isFeatured,
    required super.createdAt,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      image: json['image'],
      avatar: json['avatar'],
      phone: json['phone'],
      email: json['email'],
      isActive: json['is_active'],
      isFeatured: json['is_featured'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['image'] = image;
    data['avatar'] = avatar;
    data['phone'] = phone;
    data['email'] = email;
    data['is_active'] = isActive;
    data['is_featured'] = isFeatured;
    data['created_at'] = createdAt;
    return data;
  }

  @override
  String toString() => 'id: $id name: $name';
}
