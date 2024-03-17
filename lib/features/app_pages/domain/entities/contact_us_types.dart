import 'package:equatable/equatable.dart';

class ContactUsTypesEntity extends Equatable{
  final int id;
  final String name;

  const ContactUsTypesEntity({required this.id,required this.name});

  @override
  List<Object?> get props => [id, name];
}