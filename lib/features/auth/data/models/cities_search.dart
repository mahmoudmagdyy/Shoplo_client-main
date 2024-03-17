class CitiesSearch {
  CitiesSearch({
    required this.id,
    required this.name,
    required this.code,
    required this.phoneCode,
    required this.flag,
    required this.isActive,
    required this.createdAt,
    required this.cities,
  });

  int id;
  String name;
  String code;

  String phoneCode;
  String flag;
  bool isActive;
  String createdAt;
  List<CitySearch> cities;

  factory CitiesSearch.fromJson(Map<String, dynamic> json) => CitiesSearch(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        phoneCode: json["phone_code"],
        flag: json["flag"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        cities: List<CitySearch>.from(
            json["cities"].map((x) => CitySearch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "phone_code": phoneCode,
        "flag": flag,
        "is_active": isActive,
        "created_at": createdAt,
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
      };

  CitiesSearch copyWith({
    int? id,
    String? name,
    String? code,
    int? sort,
    String? phoneCode,
    String? flag,
    bool? isActive,
    String? createdAt,
    List<CitySearch>? cities,
  }) {
    return CitiesSearch(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      phoneCode: phoneCode ?? this.phoneCode,
      flag: flag ?? this.flag,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      cities: cities ?? this.cities,
    );
  }
}

class CitySearch {
  CitySearch({
    required this.id,
    required this.countryId,
    required this.stateId,
    required this.isActive,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  int id;
  int countryId;
  int stateId;
  bool isActive;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  factory CitySearch.fromJson(Map<String, dynamic> json) => CitySearch(
        id: json["id"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        isActive: json["is_active"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "state_id": stateId,
        "is_active": isActive,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
      };
}
