import 'package:equatable/equatable.dart';

class Category extends Equatable {
  int? id;
  String? name;
  int? order;
  String? image;
  String? type;
  bool? isActive;
  String? createdAt;

  Category(
      {this.id,
      this.name,
      this.order,
      this.image,
      this.type,
      this.isActive,
      this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    image = json['image'];
    type = json['type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        order,
        image,
        type,
        isActive,
        createdAt,
      ];
}
