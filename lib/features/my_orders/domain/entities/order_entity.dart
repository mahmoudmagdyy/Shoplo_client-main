
import 'package:equatable/equatable.dart';


class  OrderEntity extends Equatable{
  const  OrderEntity({
    required this.id,
    required this.target,
    required this.createdAt,
  });

  final String id;
  final String target;
  final String createdAt;

  @override
  // TODO: implement props
  List<Object?> get props => [id,target,createdAt];
}




