import 'package:equatable/equatable.dart';

class StoreEntity extends Equatable {
  final int id;
  final String name;
  final String username;
  final String image;
  final String avatar;
  final String phone;
  final String email;
  final bool isActive;
  final bool isFeatured;
  final String createdAt;

  const StoreEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.image,
    required this.avatar,
    required this.phone,
    required this.email,
    required this.isActive,
    required this.isFeatured,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name];
}
