import '../../domain/entities/contact_us_types.dart';

class ContactUsTypesModel extends ContactUsTypesEntity {
  const ContactUsTypesModel({required super.id, required super.name});

  factory ContactUsTypesModel.fromJson(Map<String,dynamic> json){
    return ContactUsTypesModel(
      id: json["id"],
      name: json['name']
    );
  }

  Map<String,dynamic>  toJson ()=>{
    "id":id,
    "name":name,
  };

}